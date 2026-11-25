import { BrowserRouter, Routes, Route } from "react-router-dom";
import Fo from "./pages/Fo.jsx";
import Navbar from "./components/Navbar.jsx";

function App() {
    return (
        <BrowserRouter>
            <Navbar />

            <Routes>
                <Route path="/" element={<Fo />} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;