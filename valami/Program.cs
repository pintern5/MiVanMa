using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// 1. OpenAPI (Scalar-hoz szükséges)
builder.Services.AddOpenApi();

// 2. ADATBÁZIS KAPCSOLÓ (Most true = memóriában fut; ha kész a MySQL, írd át false-ra!)
var useInMemory = true;

if (useInMemory)
{
    builder.Services.AddDbContext<AppDbContext>(options =>
        options.UseInMemoryDatabase("MiVanMaTestDb"));
}
else
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("Hiányzik a DefaultConnection az appsettings.json-ből!");

    builder.Services.AddDbContext<AppDbContext>(options =>
        options.UseMySQL(connectionString));
}

// 3. CORS engedélyezése
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

var app = builder.Build();

// 4. Adatbázis létrehozása és mintaadatok betöltése induláskor
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.EnsureCreated();

    if (!db.Articles.Any())
    {
        db.Articles.AddRange(
            new Article { Title = "Megjelent a GTA VI új előzetese", Summary = "A Rockstar Games bemutatta a GTA VI legújabb trailerét, amely új szintre emeli a nyílt világú játékélményt…", Category = "Gaming", IsFeatured = true, PublishedAt = DateTime.Now.AddMinutes(-12) },
            new Article { Title = "Új PS5 exkluzív", Summary = "A Sony nagy bejelentést tett…", Category = "Gaming", PublishedAt = DateTime.Now.AddHours(-3) },
            new Article { Title = "Új OpenAI fejlesztés", Summary = "Az OpenAI új fejlesztése...", Category = "Tech", PublishedAt = DateTime.Now.AddMinutes(-38) },
            new Article { Title = "Új iPhone érkezett", Summary = "Az Apple bemutatta legújabb modelljét…", Category = "Tech", PublishedAt = DateTime.Now.AddHours(-4) },
            new Article { Title = "Újabb madridi győzelem", Summary = "Drámai hajrával nyert rangadót...", Category = "Sport", PublishedAt = DateTime.Now.AddHours(-2) },
            new Article { Title = "NB I-ben meglepetés született", Summary = "Váratlan eredmény borzolta a kedélyeket a hétvégi fordulóban…", Category = "Sport", PublishedAt = DateTime.Now.AddHours(-1) },
            new Article { Title = "Tesla új generációs elektromos autója", Summary = "Bemutatták a Tesla új generációs elektromos...", Category = "Autók", PublishedAt = DateTime.Now.AddHours(-2) },
            new Article { Title = "Bemutatkozott az új BMW modell", Summary = "Sportos dizájn és nagyobb hatótáv…", Category = "Autók", PublishedAt = DateTime.Now.AddHours(-5) },
            new Article { Title = "Energiaárak csökkenése", Summary = "Új intézkedéseket jelentett be a kormány...", Category = "Közélet", PublishedAt = DateTime.Now.AddHours(-3) },
            new Article { Title = "Tüntetések több nagyvárosban", Summary = "Ezrek vonultak utcára a hétvégén…", Category = "Közélet", PublishedAt = DateTime.Now.AddHours(-6) }
        );
        db.SaveChanges();
    }
}

// 5. Frontend kiszolgálása a wwwroot mappából (fo.html mint kezdőlap)
var defaultFileOptions = new DefaultFilesOptions();
defaultFileOptions.DefaultFileNames.Clear();
defaultFileOptions.DefaultFileNames.Add("fo.html");

app.UseDefaultFiles(defaultFileOptions);
app.UseStaticFiles();

// 6. Scalar API Dokumentáció (/scalar/v1)
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference(options =>
    {
        options.WithTitle("MiVanMa API Dokumentáció")
               .WithTheme(ScalarTheme.Moon);
    });
}

app.UseCors();

// --- VÉGPONTOK (ENDPOINTS) ---

// Összes hír (opcionális kategória szűréssel: /api/news?category=Tech)
app.MapGet("/api/news", async (AppDbContext db, string? category) =>
{
    var query = db.Articles.AsQueryable();

    if (!string.IsNullOrWhiteSpace(category))
        query = query.Where(a => a.Category.ToLower() == category.ToLower());

    var result = await query.OrderByDescending(a => a.PublishedAt).ToListAsync();
    return Results.Ok(result);
})
.WithName("GetNews")
.WithTags("Hírek");

// Egy konkrét hír ID alapján
app.MapGet("/api/news/{id:int}", async (AppDbContext db, int id) =>
{
    var article = await db.Articles.FindAsync(id);
    return article is not null ? Results.Ok(article) : Results.NotFound("A hír nem található.");
})
.WithName("GetNewsById")
.WithTags("Hírek");

// Új hír hozzáadása
app.MapPost("/api/news", async (AppDbContext db, CreateArticleDto dto) =>
{
    var newArticle = new Article
    {
        Title = dto.Title,
        Summary = dto.Summary,
        Category = dto.Category,
        IsFeatured = dto.IsFeatured,
        PublishedAt = DateTime.Now
    };

    db.Articles.Add(newArticle);
    await db.SaveChangesAsync();

    return Results.Created($"/api/news/{newArticle.Id}", newArticle);
})
.WithName("CreateNews")
.WithTags("Hírek");

// Hír törlése
app.MapDelete("/api/news/{id:int}", async (AppDbContext db, int id) =>
{
    var article = await db.Articles.FindAsync(id);
    if (article is null) return Results.NotFound();

    db.Articles.Remove(article);
    await db.SaveChangesAsync();
    return Results.NoContent();
})
.WithName("DeleteNews")
.WithTags("Hírek");

// Oldalsáv adatok
app.MapGet("/api/sidebar", async (AppDbContext db) =>
{
    var latest = await db.Articles.OrderByDescending(a => a.PublishedAt).Take(4).ToListAsync();
    var totalCount = await db.Articles.CountAsync();

    return Results.Ok(new
    {
        Latest = latest,
        MostRead = new[] { "GTA VI minden részlet", "Új Apple termék", "Magyar gazdasági fordulat" },
        Stats = new { NewsToday = totalCount, TotalReads = 12458, TopCategory = "Gaming" },
        Trending = new[] { "#AI", "#GTA6", "#Apple", "#MagyarSport" }
    });
})
.WithName("GetSidebar")
.WithTags("Oldalsáv");

// Regisztráció (auth.js-hez)
app.MapPost("/api/register", async (AppDbContext db, AuthDto dto) =>
{
    if (string.IsNullOrWhiteSpace(dto.Username) || string.IsNullOrWhiteSpace(dto.Password))
        return Results.BadRequest(new { Message = "Minden mező kitöltése kötelező!" });

    var exists = await db.Users.AnyAsync(u => u.Username == dto.Username);
    if (exists)
        return Results.BadRequest(new { Message = "Ez a felhasználónév már foglalt!" });

    var user = new User { Username = dto.Username, Password = dto.Password };
    db.Users.Add(user);
    await db.SaveChangesAsync();

    return Results.Ok(new { Message = "Sikeres regisztráció!", Username = user.Username });
})
.WithName("Register")
.WithTags("Felhasználók");

// Bejelentkezés (auth.js-hez)
app.MapPost("/api/login", async (AppDbContext db, AuthDto dto) =>
{
    var user = await db.Users.FirstOrDefaultAsync(u => u.Username == dto.Username && u.Password == dto.Password);
    if (user is null)
        return Results.Unauthorized();

    return Results.Ok(new { Message = "Sikeres bejelentkezés!", Username = user.Username });
})
.WithName("Login")
.WithTags("Felhasználók");

app.Run();

// --- ADATBÁZIS ÉS MODELLEK ---

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Article> Articles => Set<Article>();
    public DbSet<User> Users => Set<User>();
}

public class Article
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Summary { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public bool IsFeatured { get; set; }
    public DateTime PublishedAt { get; set; }
}

public class User
{
    public int Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

public record CreateArticleDto(string Title, string Summary, string Category, bool IsFeatured = false);
public record AuthDto(string Username, string Password);