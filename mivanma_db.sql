-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Nov 25. 14:23
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `mivanma_db`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `articles`
--

CREATE TABLE `articles` (
  `Id` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Summary` text NOT NULL,
  `Content` longtext DEFAULT NULL,
  `ImageUrl` varchar(500) DEFAULT NULL,
  `Category` varchar(50) NOT NULL,
  `IsFeatured` tinyint(1) NOT NULL DEFAULT 0,
  `Views` int(11) NOT NULL DEFAULT 0,
  `PublishedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `articles`
--

INSERT INTO `articles` (`Id`, `Title`, `Summary`, `Content`, `ImageUrl`, `Category`, `IsFeatured`, `Views`, `PublishedAt`) VALUES
(1, 'Megjelent a GTA VI új előzetese', 'A Rockstar Games bemutatta a GTA VI legújabb trailerét, amely új szintre emeli a nyílt világú játékélményt…', 'Itt található a(z) \"Megjelent a GTA VI új előzetese\" című cikk teljes szövege...', 'images/gta6_featured.jpg', 'Gaming', 1, 0, '2026-11-25 13:40:37'),
(2, 'GTA VI új trailer', 'A Rockstar ismét felrobbantotta az internetet…', 'Itt található a(z) \"GTA VI új trailer\" című cikk teljes szövege...', 'images/gta6_trailer.jpg', 'Gaming', 0, 0, '2026-11-25 13:22:37'),
(3, 'Új PS5 exkluzív', 'A Sony nagy bejelentést tett…', 'Itt található a(z) \"Új PS5 exkluzív\" című cikk teljes szövege...', 'images/ps5.jpg', 'Gaming', 0, 0, '2026-11-25 10:52:37'),
(4, 'E-sport rekordnézettség', 'Több millió néző követte az eseményt…', 'Itt található a(z) \"E-sport rekordnézettség\" című cikk teljes szövege...', 'images/esport.jpg', 'Gaming', 0, 0, '2026-11-25 09:52:37'),
(5, 'Új GTA Online frissítés', 'Új küldetések, járművek és extra tartalmak érkeztek…', 'Itt található a(z) \"Új GTA Online frissítés\" című cikk teljes szövege...', 'images/gta_online.jpg', 'Gaming', 0, 0, '2026-11-25 08:52:37'),
(6, 'Switch 2-ről új részletek jöttek', 'A hordozható konzol új funkciói sok rajongót izgalomba hoztak…', 'Itt található a(z) \"Switch 2-ről új részletek jöttek\" című cikk teljes szövege...', 'images/switch2.jpg', 'Gaming', 0, 0, '2026-11-25 07:52:37'),
(7, 'Nagy RPG-bejelentés érkezett', 'Egy régóta várt fantasy játék végre hivatalosan is lelepleződött…', 'Itt található a(z) \"Nagy RPG-bejelentés érkezett\" című cikk teljes szövege...', 'images/rpg.jpg', 'Gaming', 0, 0, '2026-11-25 06:52:37'),
(8, 'Steam rekordot döntött', 'Minden eddiginél több játékos volt egyszerre online a platformon…', 'Itt található a(z) \"Steam rekordot döntött\" című cikk teljes szövege...', 'images/steam.jpg', 'Gaming', 0, 0, '2026-11-25 05:52:37'),
(9, 'Új horrorjáték jön ősszel', 'A fejlesztők már most ígérik az év egyik legijesztőbb élményét…', 'Itt található a(z) \"Új horrorjáték jön ősszel\" című cikk teljes szövege...', 'images/horror.jpg', 'Gaming', 0, 0, '2026-11-25 04:52:37'),
(10, 'Mobiljáték tarol világszerte', 'Rövid idő alatt hatalmas játékosszámot ért el az új cím…', 'Itt található a(z) \"Mobiljáték tarol világszerte\" című cikk teljes szövege...', 'images/mobile_game.jpg', 'Gaming', 0, 0, '2026-11-25 03:52:37'),
(11, 'Új MMO készül bejelentésre', 'Egy hatalmas online világot ígérnek a fejlesztők a következő évre…', 'Itt található a(z) \"Új MMO készül bejelentésre\" című cikk teljes szövege...', 'images/mmo.jpg', 'Gaming', 0, 0, '2026-11-25 02:52:37'),
(12, 'Indie játék lett az év meglepetése', 'Egy kis csapat alkotása váratlanul lett globális siker…', 'Itt található a(z) \"Indie játék lett az év meglepetése\" című cikk teljes szövege...', 'images/indie.jpg', 'Gaming', 0, 0, '2026-11-25 01:52:37'),
(13, 'Új battle royale térkép érkezik', 'A fejlesztők teljesen új helyszínekkel frissítik a népszerű játékot…', 'Itt található a(z) \"Új battle royale térkép érkezik\" című cikk teljes szövege...', 'images/battleroyale.jpg', 'Gaming', 0, 0, '2026-11-25 00:52:37'),
(14, 'VR-játékok új hulláma jön', 'A stúdiók egyre több prémium címet készítenek virtuális valóságra…', 'Itt található a(z) \"VR-játékok új hulláma jön\" című cikk teljes szövege...', 'images/vr_games.jpg', 'Gaming', 0, 0, '2026-11-24 23:52:37'),
(15, 'Új OpenAI fejlesztés', 'Az OpenAI új fejlesztése...', 'Itt található a(z) \"Új OpenAI fejlesztés\" című cikk teljes szövege...', 'images/openai.jpg', 'Tech', 0, 0, '2026-11-25 13:14:37'),
(16, 'Új iPhone érkezett', 'Az Apple bemutatta legújabb modelljét…', 'Itt található a(z) \"Új iPhone érkezett\" című cikk teljes szövege...', 'images/iphone.jpg', 'Tech', 0, 0, '2026-11-25 09:52:37'),
(17, 'Globális kibertámadás', 'Több európai cég rendszere is leállt…', 'Itt található a(z) \"Globális kibertámadás\" című cikk teljes szövege...', 'images/cyberattack.jpg', 'Tech', 0, 0, '2026-11-25 08:52:37'),
(18, 'AI-alapú kereső jön Európába', 'Új generációs keresőszolgáltatás érkezhet mesterséges intelligenciával támogatva…', 'Itt található a(z) \"AI-alapú kereső jön Európába\" című cikk teljes szövege...', 'images/ai_search.jpg', 'Tech', 0, 0, '2026-11-25 07:52:37'),
(19, 'Hatalmas chipberuházás indul', 'Több milliárd eurós fejlesztés indul a félvezetőiparban…', 'Itt található a(z) \"Hatalmas chipberuházás indul\" című cikk teljes szövege...', 'images/chips.jpg', 'Tech', 0, 0, '2026-11-25 06:52:37'),
(20, 'Új Windows funkciók érkeznek', 'A Microsoft több praktikus újítást is bevezet a rendszerében…', 'Itt található a(z) \"Új Windows funkciók érkeznek\" című cikk teljes szövege...', 'images/windows.jpg', 'Tech', 0, 0, '2026-11-25 05:52:37'),
(21, 'Okosórák új generációja debütált', 'Fejlettebb egészségfigyelés és hosszabb üzemidő az új modellekben…', 'Itt található a(z) \"Okosórák új generációja debütált\" című cikk teljes szövege...', 'images/smartwatch.jpg', 'Tech', 0, 0, '2026-11-25 04:52:37'),
(22, 'Robotika a gyárakban', 'Egyre gyorsabban terjednek az automatizált gyártósorok Európában…', 'Itt található a(z) \"Robotika a gyárakban\" című cikk teljes szövege...', 'images/robotics.jpg', 'Tech', 0, 0, '2026-11-25 03:52:37'),
(23, 'Forradalmi akkumulátortechnológia', 'Gyorsabb töltést és jobb teljesítményt ígér az új fejlesztés…', 'Itt található a(z) \"Forradalmi akkumulátortechnológia\" című cikk teljes szövege...', 'images/battery_tech.jpg', 'Tech', 0, 0, '2026-11-25 02:52:37'),
(24, 'Új VR headset érkezik', 'A következő generációs eszköz élesebb képet és gyorsabb reakcióidőt kínál…', 'Itt található a(z) \"Új VR headset érkezik\" című cikk teljes szövege...', 'images/vr_headset.jpg', 'Tech', 0, 0, '2026-11-25 01:52:37'),
(25, 'Felhőszolgáltatások új korszaka', 'Egyre több vállalat áll át hibrid és AI-támogatott infrastruktúrára…', 'Itt található a(z) \"Felhőszolgáltatások új korszaka\" című cikk teljes szövege...', 'images/cloud.jpg', 'Tech', 0, 0, '2026-11-25 00:52:37'),
(26, 'Új generációs processzorok jönnek', 'Nagyobb teljesítmény és alacsonyabb fogyasztás várható az új chipektől…', 'Itt található a(z) \"Új generációs processzorok jönnek\" című cikk teljes szövege...', 'images/cpu.jpg', 'Tech', 0, 0, '2026-11-24 23:52:37'),
(27, 'Okosotthon eszközök terjedése', 'Egyre népszerűbbek az automatizált, hangvezérelt otthoni rendszerek…', 'Itt található a(z) \"Okosotthon eszközök terjedése\" című cikk teljes szövege...', 'images/smarthome.jpg', 'Tech', 0, 0, '2026-11-24 22:52:37'),
(28, 'Újabb madridi győzelem', 'Drámai hajrával nyert rangadót...', 'Itt található a(z) \"Újabb madridi győzelem\" című cikk teljes szövege...', 'images/madrid.jpg', 'Sport', 0, 0, '2026-11-25 11:52:37'),
(29, 'Magyar válogatott győzelem', 'Izgalmas mérkőzés után sikerült nyerni…', 'Itt található a(z) \"Magyar válogatott győzelem\" című cikk teljes szövege...', 'images/valogatott.jpg', 'Sport', 0, 0, '2026-11-25 10:52:37'),
(30, 'BL-sorsolás elkészült', 'Kemény ellenfelek várnak a csapatokra…', 'Itt található a(z) \"BL-sorsolás elkészült\" című cikk teljes szövege...', 'images/bl.jpg', 'Sport', 0, 0, '2026-11-25 09:52:37'),
(31, 'NB I-ben meglepetés született', 'Váratlan eredmény borzolta a kedélyeket a hétvégi fordulóban…', 'Itt található a(z) \"NB I-ben meglepetés született\" című cikk teljes szövege...', 'images/nb1.jpg', 'Sport', 0, 0, '2026-11-25 12:52:37'),
(32, 'Új rekord született maratonon', 'Történelmi időeredményt futott az idei nemzetközi verseny győztese…', 'Itt található a(z) \"Új rekord született maratonon\" című cikk teljes szövege...', 'images/marathon.jpg', 'Sport', 0, 0, '2026-11-25 08:52:37'),
(33, 'Tenisztorna nagy fordulata', 'A favorit kiesett, új esélyes lépett elő a tornán…', 'Itt található a(z) \"Tenisztorna nagy fordulata\" című cikk teljes szövege...', 'images/tennis.jpg', 'Sport', 0, 0, '2026-11-25 07:52:37'),
(34, 'Kosárlabda-döntő közeleg', 'Két topcsapat csap össze a szezon legjobban várt meccsén…', 'Itt található a(z) \"Kosárlabda-döntő közeleg\" című cikk teljes szövege...', 'images/basketball.jpg', 'Sport', 0, 0, '2026-11-25 06:52:37'),
(35, 'Forma–1-ben új fejlesztések jönnek', 'A csapatok technikai újításokkal készülnek a következő futamra…', 'Itt található a(z) \"Forma–1-ben új fejlesztések jönnek\" című cikk teljes szövege...', 'images/f1.jpg', 'Sport', 0, 0, '2026-11-25 05:52:37'),
(36, 'Úszó EB: új magyar érem', 'Remek teljesítményt nyújtott a magyar csapat a döntőben…', 'Itt található a(z) \"Úszó EB: új magyar érem\" című cikk teljes szövege...', 'images/swimming.jpg', 'Sport', 0, 0, '2026-11-25 04:52:37'),
(37, 'Tesla új generációs elektromos autója', 'Bemutatták a Tesla új generációs elektromos...', 'Itt található a(z) \"Tesla új generációs elektromos autója\" című cikk teljes szövege...', 'images/tesla.jpg', 'Autók', 0, 0, '2026-11-25 11:53:23'),
(38, 'Bemutatkozott az új BMW modell', 'Sportos dizájn és nagyobb hatótáv…', 'Itt található a(z) \"Bemutatkozott az új BMW modell\" című cikk teljes szövege...', 'images/bmw.jpg', 'Autók', 0, 0, '2026-11-25 08:53:23'),
(39, 'Önvezető autók tesztelése', 'Európában is megkezdődtek a közúti tesztek…', 'Itt található a(z) \"Önvezető autók tesztelése\" című cikk teljes szövege...', 'images/selfdriving.jpg', 'Autók', 0, 0, '2026-11-25 07:53:23'),
(40, 'Csökkenhetnek az elektromos autóárak', 'Új piaci verseny indult, ami lefelé nyomhatja az árakat…', 'Itt található a(z) \"Csökkenhetnek az elektromos autóárak\" című cikk teljes szövege...', 'images/ev_prices.jpg', 'Autók', 0, 0, '2026-11-25 06:53:23'),
(41, 'Új hibrid SUV érkezik Európába', 'Nagyobb hatótávval és modernebb fedélzeti rendszerrel jön az új modell…', 'Itt található a(z) \"Új hibrid SUV érkezik Európába\" című cikk teljes szövege...', 'images/hybrid_suv.jpg', 'Autók', 0, 0, '2026-11-25 05:53:23'),
(42, 'Autópályás fejlesztések jönnek', 'Több fontos útvonalon indulnak bővítések és korszerűsítések…', 'Itt található a(z) \"Autópályás fejlesztések jönnek\" című cikk teljes szövege...', 'images/highway.jpg', 'Autók', 0, 0, '2026-11-25 04:53:23'),
(43, 'Rekordot döntött az EV-eladás', 'Soha ennyi elektromos autót nem adtak még el egy negyedév alatt…', 'Itt található a(z) \"Rekordot döntött az EV-eladás\" című cikk teljes szövege...', 'images/ev_sales.jpg', 'Autók', 0, 0, '2026-11-25 03:53:23'),
(44, 'Új akkumulátorplatform készül', 'Gyorsabb töltés és hosszabb élettartam lehet az új fejlesztés előnye…', 'Itt található a(z) \"Új akkumulátorplatform készül\" című cikk teljes szövege...', 'images/ev_battery.jpg', 'Autók', 0, 0, '2026-11-25 02:53:23'),
(45, 'Okosfedélzeti rendszerek terjednek', 'Egyre több modell kap fejlett digitális vezérlést és AI-segítséget…', 'Itt található a(z) \"Okosfedélzeti rendszerek terjednek\" című cikk teljes szövege...', 'images/car_infotainment.jpg', 'Autók', 0, 0, '2026-11-25 01:53:23'),
(46, 'Bemutatták az új elektromos sportkocsit', 'Kimagasló gyorsulással és futurisztikus dizájnnal érkezett az új modell…', 'Itt található a(z) \"Bemutatták az új elektromos sportkocsit\" című cikk teljes szövege...', 'images/ev_sportscar.jpg', 'Autók', 0, 0, '2026-11-25 00:53:23'),
(47, 'Nő az érdeklődés a használt EV-k iránt', 'Egyre többen választanak kedvezőbb árú elektromos autókat a másodlagos piacon…', 'Itt található a(z) \"Nő az érdeklődés a használt EV-k iránt\" című cikk teljes szövege...', 'images/used_ev.jpg', 'Autók', 0, 0, '2026-11-24 23:53:23'),
(48, 'Új töltőhálózat épül Magyarországon', 'Több városban és főútvonal mentén bővül az elektromos töltőinfrastruktúra…', 'Itt található a(z) \"Új töltőhálózat épül Magyarországon\" című cikk teljes szövege...', 'images/ev_charger.jpg', 'Autók', 0, 0, '2026-11-24 22:53:23'),
(49, 'Autóipari chiphiány enyhülhet', 'Elemzők szerint stabilizálódhat az ellátási lánc a következő hónapokban…', 'Itt található a(z) \"Autóipari chiphiány enyhülhet\" című cikk teljes szövege...', 'images/auto_chips.jpg', 'Autók', 0, 0, '2026-11-24 21:53:23'),
(50, 'Energiaárak csökkenése', 'Új intézkedéseket jelentett be a kormány...', 'Itt található a(z) \"Energiaárak csökkenése\" című cikk teljes szövege...', 'images/energia.jpg', 'Közélet', 0, 0, '2026-11-25 10:53:23'),
(51, 'Tüntetések több nagyvárosban', 'Ezrek vonultak utcára a hétvégén…', 'Itt található a(z) \"Tüntetések több nagyvárosban\" című cikk teljes szövege...', 'images/tuntetes.jpg', 'Közélet', 0, 0, '2026-11-25 07:53:23'),
(52, 'Önkormányzati változások jönnek', 'Átalakulhat a helyi döntéshozatal rendszere…', 'Itt található a(z) \"Önkormányzati változások jönnek\" című cikk teljes szövege...', 'images/onkormanyzat.jpg', 'Közélet', 0, 0, '2026-11-25 06:53:23'),
(53, 'Új törvényjavaslat került napirendre', 'Élénk vitát váltott ki az új tervezet a parlamentben…', 'Itt található a(z) \"Új törvényjavaslat került napirendre\" című cikk teljes szövege...', 'images/parlament.jpg', 'Közélet', 0, 0, '2026-11-25 05:53:23'),
(54, 'Oktatási reformról egyeztetnek', 'Több szervezet bevonásával indulhatnak új tárgyalások…', 'Itt található a(z) \"Oktatási reformról egyeztetnek\" című cikk teljes szövege...', 'images/oktatas.jpg', 'Közélet', 0, 0, '2026-11-25 04:53:23'),
(55, 'Egészségügyi fejlesztések indulnak', 'Kórházakat és rendelőket érintő beruházásokat jelentettek be…', 'Itt található a(z) \"Egészségügyi fejlesztések indulnak\" című cikk teljes szövege...', 'images/egeszsegugy.jpg', 'Közélet', 0, 0, '2026-11-25 03:53:23'),
(56, 'Szociális támogatások bővülhetnek', 'Új intézkedéscsomag segítheti a nehezebb helyzetben élő családokat…', 'Itt található a(z) \"Szociális támogatások bővülhetnek\" című cikk teljes szövege...', 'images/szocialis.jpg', 'Közélet', 0, 0, '2026-11-25 02:53:23'),
(57, 'Közlekedési szabályok változhatnak', 'Több új javaslat is érkezett a városi közlekedés átalakítására…', 'Itt található a(z) \"Közlekedési szabályok változhatnak\" című cikk teljes szövege...', 'images/kozlekedes.jpg', 'Közélet', 0, 0, '2026-11-25 01:53:23'),
(58, 'Lakhatási program indulhat', 'Új otthonteremtési lehetőségeket jelenthet be a kormányzat…', 'Itt található a(z) \"Lakhatási program indulhat\" című cikk teljes szövege...', 'images/lakhatas.jpg', 'Közélet', 0, 0, '2026-11-25 00:53:23'),
(59, 'Új városfejlesztési tervek készülnek', 'Parkok, utak és közösségi terek fejlesztése is szerepel a programban…', 'Itt található a(z) \"Új városfejlesztési tervek készülnek\" című cikk teljes szövege...', 'images/varosfejlesztes.jpg', 'Közélet', 0, 0, '2026-11-24 23:53:23'),
(60, 'Munkaerőpiaci intézkedéseket jelentettek be', 'Az új csomag a foglalkoztatás élénkítését célozza több ágazatban…', 'Itt található a(z) \"Munkaerőpiaci intézkedéseket jelentettek be\" című cikk teljes szövege...', 'images/munkaeropiac.jpg', 'Közélet', 0, 0, '2026-11-24 22:53:23'),
(61, 'Vitát váltott ki az új rendelet', 'Ellenzéki és civil szervezetek is reagáltak a friss döntésre…', 'Itt található a(z) \"Vitát váltott ki az új rendelet\" című cikk teljes szövege...', 'images/vita.jpg', 'Közélet', 0, 0, '2026-11-24 21:53:23'),
(62, 'Önkormányzati beruházások indulnak', 'Több településen kezdődhetnek nagyszabású helyi fejlesztések…', 'Itt található a(z) \"Önkormányzati beruházások indulnak\" című cikk teljes szövege...', 'images/beruhazas.jpg', 'Közélet', 0, 0, '2026-11-24 20:53:23');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `Id` int(11) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(20) NOT NULL DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`Id`, `Username`, `Password`, `Role`) VALUES
(1, 'admin', 'admin123', 'Admin'),
(2, 'testuser', '1234', 'User');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `articles`
--
ALTER TABLE `articles`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
