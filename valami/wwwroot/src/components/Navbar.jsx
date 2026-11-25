
import { Link } from "react-router-dom";
import "./Navbar.css";

function Navbar() {
    return (
        <header className="navbar">
            <Link to="/" className="logo">
                MiVanMa
            </Link>

            <div className="navbar-search">
                <input
                    type="text"
                    placeholder="Keresés a hírek között..."
                />
                <button>🔍</button>
            </div>

            <nav className="navbar-links">
                <Link to="/friss">Friss</Link>
                <Link to="/szemelyre-szabott">Személyre szabott</Link>
                <Link to="/rolunk">Rólunk</Link>
            </nav>

            <button className="login-button">
                Bejelentkezés
            </button>
        </header>
    );
}

export default Navbar;
