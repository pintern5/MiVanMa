using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// 1. OpenAPI (Scalar-hoz szükséges)
builder.Services.AddOpenApi();

// 2. ADATBÁZIS KAPCSOLÓ (Átállítva MySQL-re!)
var useInMemory = false;

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

// 4. Adatbázis kapcsolat ellenőrzése induláskor
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.EnsureCreated();
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

// Egy konkrét hír ID alapján (és növeli az olvasottságot)
app.MapGet("/api/news/{id:int}", async (AppDbContext db, int id) =>
{
    var article = await db.Articles.FindAsync(id);
    if (article is null) return Results.NotFound("A hír nem található.");

    article.Views++;
    await db.SaveChangesAsync();

    return Results.Ok(article);
})
.WithName("GetNewsById")
.WithTags("Hírek");

// Új hír hozzáadása (Admin)
app.MapPost("/api/news", async (AppDbContext db, ArticleDto dto) =>
{
    var newArticle = new Article
    {
        Title = dto.Title,
        Summary = dto.Summary,
        Content = dto.Content,
        ImageUrl = dto.ImageUrl,
        Category = dto.Category,
        IsFeatured = dto.IsFeatured,
        Views = 0,
        PublishedAt = DateTime.Now
    };

    db.Articles.Add(newArticle);
    await db.SaveChangesAsync();

    return Results.Created($"/api/news/{newArticle.Id}", newArticle);
})
.WithName("CreateNews")
.WithTags("Hírek");

// Hír módosítása (Admin)
app.MapPut("/api/news/{id:int}", async (AppDbContext db, int id, ArticleDto dto) =>
{
    var article = await db.Articles.FindAsync(id);
    if (article is null) return Results.NotFound("A hír nem található.");

    article.Title = dto.Title;
    article.Summary = dto.Summary;
    article.Content = dto.Content;
    article.ImageUrl = dto.ImageUrl;
    article.Category = dto.Category;
    article.IsFeatured = dto.IsFeatured;

    await db.SaveChangesAsync();
    return Results.Ok(article);
})
.WithName("UpdateNews")
.WithTags("Hírek");

// Hír törlése (Admin)
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

// Oldalsáv adatok (valódi adatbázisból számolva)
app.MapGet("/api/sidebar", async (AppDbContext db) =>
{
    var latest = await db.Articles.OrderByDescending(a => a.PublishedAt).Take(4).ToListAsync();
    var mostRead = await db.Articles.OrderByDescending(a => a.Views).Take(3).Select(a => a.Title).ToListAsync();
    var totalCount = await db.Articles.CountAsync();
    var totalViews = await db.Articles.SumAsync(a => a.Views);

    return Results.Ok(new
    {
        Latest = latest,
        MostRead = mostRead.Any() ? mostRead : new List<string> { "GTA VI minden részlet", "Új Apple termék", "Magyar gazdasági fordulat" },
        Stats = new { NewsToday = totalCount, TotalReads = totalViews, TopCategory = "Gaming" },
        Trending = new[] { "#AI", "#GTA6", "#Apple", "#MagyarSport" }
    });
})
.WithName("GetSidebar")
.WithTags("Oldalsáv");

// Regisztráció
app.MapPost("/api/register", async (AppDbContext db, AuthDto dto) =>
{
    if (string.IsNullOrWhiteSpace(dto.Username) || string.IsNullOrWhiteSpace(dto.Password))
        return Results.BadRequest(new { Message = "Minden mező kitöltése kötelező!" });

    var exists = await db.Users.AnyAsync(u => u.Username == dto.Username);
    if (exists)
        return Results.BadRequest(new { Message = "Ez a felhasználónév már foglalt!" });

    var user = new User 
    { 
        Username = dto.Username, 
        Password = dto.Password,
        Role = "User"
    };
    db.Users.Add(user);
    await db.SaveChangesAsync();

    return Results.Ok(new { Message = "Sikeres regisztráció!", Username = user.Username, Role = user.Role });
})
.WithName("Register")
.WithTags("Felhasználók");

// Bejelentkezés
app.MapPost("/api/login", async (AppDbContext db, AuthDto dto) =>
{
    var user = await db.Users.FirstOrDefaultAsync(u => u.Username == dto.Username && u.Password == dto.Password);
    if (user is null)
        return Results.Unauthorized();

    return Results.Ok(new { Message = "Sikeres bejelentkezés!", Username = user.Username, Role = user.Role });
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
    public string? Content { get; set; }
    public string? ImageUrl { get; set; }
    public string Category { get; set; } = string.Empty;
    public bool IsFeatured { get; set; }
    public int Views { get; set; }
    public DateTime PublishedAt { get; set; }
}

public class User
{
    public int Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string Role { get; set; } = "User";
}

public record ArticleDto(string Title, string Summary, string? Content, string? ImageUrl, string Category, bool IsFeatured = false);
public record AuthDto(string Username, string Password);
