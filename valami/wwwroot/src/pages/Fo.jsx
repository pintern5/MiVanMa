import "./Fo.css";
import { Link } from "react-router-dom";

const kategoriak = [
    {
        nev: "💻 Tech",
        szin: "tech-line",
        osszes: "/techosszes",
        hirek: [
            {
                cim: "Új OpenAI fejlesztés",
                leiras: "Az OpenAI új fejlesztése...",
                kep: "/images/tech1.webp",
                link: "/tech"
            },
            {
                cim: "Új iPhone érkezett",
                leiras: "Az Apple bemutatta legújabb modelljét…",
                kep: "/images/tech2.webp",
                link: "/tech2"
            },
            {
                cim: "Globális kibertámadás",
                leiras: "Több európai cég rendszere is leállt…",
                kep: "/images/tech3.webp",
                link: "/tech3"
            }
        ]
    },
    {
        nev: "⚽ Sport",
        szin: "sport-line",
        osszes: "/sportosszes",
        hirek: [
            {
                cim: "Újabb madridi győzelem",
                leiras: "Drámai hajrával nyert rangadót...",
                kep: "/images/sport1.jpg",
                link: "/sport"
            },
            {
                cim: "Magyar válogatott győzelem",
                leiras: "Izgalmas mérkőzés után sikerült nyerni…",
                kep: "/images/sport2.png",
                link: "/sport2"
            },
            {
                cim: "BL-sorsolás elkészült",
                leiras: "Kemény ellenfelek várnak a csapatokra…",
                kep: "/images/sport3.jpg",
                link: "/sport3"
            }
        ]
    },
    {
        nev: "🎮 Gaming",
        szin: "gaming-line",
        osszes: "/gamingosszes",
        hirek: [
            {
                cim: "GTA VI új trailer",
                leiras: "A Rockstar ismét felrobbantotta az internetet…",
                kep: "/images/gaming1.png",
                link: "/gta",
                gaming: true
            },
            {
                cim: "Új PS5 exkluzív",
                leiras: "A Sony nagy bejelentést tett…",
                kep: "/images/gaming2.png",
                link: "/gaming2",
                gaming: true
            },
            {
                cim: "E-sport rekordnézettség",
                leiras: "Több millió néző követte az eseményt…",
                kep: "/images/gaming4.png",
                link: "/gaming3",
                gaming: true
            }
        ]
    },
    {
        nev: "🚗 Autók",
        szin: "auto-line",
        osszes: "/autokosszes",
        hirek: [
            {
                cim: "Tesla új generációs elektromos autója",
                leiras: "Bemutatták a Tesla új generációs elektromos...",
                kep: "/images/auto1.png",
                link: "/auto"
            },
            {
                cim: "Bemutatkozott az új BMW modell",
                leiras: "Sportos dizájn és nagyobb hatótáv…",
                kep: "/images/auto2.webp",
                link: "/auto2"
            },
            {
                cim: "Önvezető autók tesztelése",
                leiras: "Európában is megkezdődtek a közúti tesztek…",
                kep: "/images/auto3.jpg",
                link: "/auto3"
            }
        ]
    },
    {
        nev: "🏛️ Közélet",
        szin: "kozelet-line",
        osszes: "/kozeletosszes",
        hirek: [
            {
                cim: "Energiaárak csökkenése",
                leiras: "Új intézkedéseket jelentett be a kormány...",
                kep: "/images/kozelet1.png",
                link: "/kozelet"
            },
            {
                cim: "Tüntetések több nagyvárosban",
                leiras: "Ezrek vonultak utcára a hétvégén…",
                kep: "/images/kozelet2.jpg",
                link: "/kozelet2"
            },
            {
                cim: "Önkormányzati változások jönnek",
                leiras: "Átalakulhat a helyi döntéshozatal rendszere…",
                kep: "/images/kozelet3.jpg",
                link: "/kozelet3"
            }
        ]
    }
];

function Fo() {
    return (
        <>
            <main>
                <div className="main-left">

                    <section>
                        <div className="hero">
                            <h1>Mai kiemelt hírek</h1>
                            <p>A legfontosabb történések egy helyen.</p>
                        </div>

                        <div className="news-grid">
                            <Link to="/gta" className="card-link">
                                <div className="card gaming-card featured-card">
                                    <span className="category">🎮 Gaming</span>
                                    <h2>Megjelent a GTA VI új előzetese</h2>
                                    <p>
                                        A Rockstar Games bemutatta a GTA VI
                                        legújabb trailerét, amely új szintre
                                        emeli a nyílt világú játékélményt…
                                    </p>
                                    <img
                                        className="card-image"
                                        src="/images/gaming1.png"
                                        alt="GTA VI"
                                    />
                                </div>
                            </Link>
                        </div>
                    </section>

                    <div className="category-lines">
                        {kategoriak.map((kategoria) => (
                            <div
                                className={`category-line ${kategoria.szin}`}
                                key={kategoria.nev}
                            >
                                <div className="category-header">
                                    <h2>{kategoria.nev}</h2>

                                    <Link to={kategoria.osszes}>
                                        Összes hír →
                                    </Link>
                                </div>

                                <div className="category-news">
                                    {kategoria.hirek.map((hir) => (
                                        <Link
                                            to={hir.link}
                                            className="card-link"
                                            key={hir.cim}
                                        >
                                            <div
                                                className={`card ${
                                                    hir.gaming ? "gaming-card" : ""
                                                }`}
                                            >
                                                <h3>{hir.cim}</h3>
                                                <p>{hir.leiras}</p>

                                                <img
                                                    className="card-image"
                                                    src={hir.kep}
                                                    alt={hir.cim}
                                                />
                                            </div>
                                        </Link>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <aside>
                    <div className="card sidebar-block">
                        <h3>🕒 Legfrissebb hírek</h3>

                        <ul className="latest-list">
                            <li>
                                <span className="time">12 perce</span>
                                <Link to="/gta">
                                    Új GTA VI információk szivárogtak ki
                                </Link>
                            </li>

                            <li>
                                <span className="time">38 perce</span>
                                <Link to="/tech">
                                    AI-alapú kereső jön Európába
                                </Link>
                            </li>

                            <li>
                                <span className="time">1 órája</span>
                                <Link to="/sport">
                                    NB I: váratlan edzőváltás
                                </Link>
                            </li>

                            <li>
                                <span className="time">2 órája</span>
                                <Link to="/auto">
                                    Elektromos autók ára csökkenhet
                                </Link>
                            </li>
                        </ul>
                    </div>

                    <div className="card sidebar-block">
                        <h3>⭐ Neked ajánljuk</h3>

                        <div className="recommend">
                            <Link to="/gta">
                                🎮 Miért a GTA VI lesz az évtized játéka?
                            </Link>
                            <Link to="/tech">
                                💻 5 tech trend, ami felforgatja 2025-öt
                            </Link>
                            <Link to="/kozelet">
                                🏛️ Mi változik az új törvényekkel?
                            </Link>
                        </div>
                    </div>

                    <div className="card sidebar-block">
                        <h3>🔥 Legolvasottabb</h3>

                        <ol className="popular">
                            <li>
                                <Link to="/gta">GTA VI minden részlet</Link>
                            </li>
                            <li>
                                <Link to="/tech">Új Apple termék</Link>
                            </li>
                            <li>
                                <Link to="/kozelet">
                                    Magyar gazdasági fordulat
                                </Link>
                            </li>
                        </ol>
                    </div>

                    <div className="card sidebar-block stats">
                        <h3>📊 Mai stat</h3>
                        <div>📰 24 hír ma</div>
                        <div>👁 12 458 olvasás</div>
                        <div>🔥 Top kategória: Gaming</div>
                    </div>

                    <div className="card sidebar-block">
                        <h3>📌 Trending</h3>

                        <div className="tags">
                            <span>#AI</span>
                            <span>#GTA6</span>
                            <span>#Apple</span>
                            <span>#MagyarSport</span>
                        </div>
                    </div>
                </aside>
            </main>

            <footer className="news-footer">
                <h3>📰 További hírek</h3>

                <div className="footer-news-scroll">
                    <div className="footer-news-card">
                        <span className="category">Tech</span>
                        <h4>Új AI-eszköz érkezett</h4>
                        <p>Az új fejlesztés gyorsabb és pontosabb…</p>
                    </div>

                    <div className="footer-news-card">
                        <span className="category">Sport</span>
                        <h4>NB I meglepetés eredmény</h4>
                        <p>Váratlan fordulat a bajnokságban…</p>
                    </div>

                    <div className="footer-news-card gaming">
                        <span className="category">Gaming</span>
                        <h4>Új GTA Online frissítés</h4>
                        <p>Új küldetések és járművek…</p>
                    </div>

                    <div className="footer-news-card">
                        <span className="category">Autók</span>
                        <h4>Elektromos SUV bemutató</h4>
                        <p>Nagyobb hatótáv, alacsonyabb ár…</p>
                    </div>

                    <div className="footer-news-card">
                        <span className="category">Közélet</span>
                        <h4>Új döntések születtek</h4>
                        <p>Fontos változások jönnek…</p>
                    </div>
                </div>

                <p className="footer-copy">
                    © 2026 MiVanMa – minden jog fenntartva
                </p>
            </footer>
        </>
    );
}

export default Fo;