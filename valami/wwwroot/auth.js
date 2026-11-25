let isLoggedIn = false;
const API_URL = "/api"; // A C# backend API útvonala

/* ===== INPUTOK ===== */
const username = document.getElementById('username');
const password = document.getElementById('password');
const password2 = document.getElementById('password2');
const loginBtn = document.getElementById('loginBtn');
const modal = document.getElementById('loginModal');
const loginTab = document.getElementById('loginTab');
const registerTab = document.getElementById('registerTab');
const formTitle = document.getElementById('formTitle');
const submitBtn = document.getElementById('submitBtn');

/* ===== TOAST ===== */
function showToast(message, type = "info") {
  const toastContainer = document.getElementById("toast");
  const toast = document.createElement("div");
  toast.className = `toast ${type}`;
  toast.textContent = message;
  toastContainer.appendChild(toast);

  setTimeout(() => {
    toast.style.opacity = "0";
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

/* ===== BEJELENTKEZÉSI ÁLLAPOT VISSZATÖLTÉSE ===== */
try {
  if (localStorage.getItem("isLoggedIn") === "true") {
    isLoggedIn = true;
    const user = localStorage.getItem("loggedInUser");
    if (user) loginBtn.textContent = user + " (Kijelentkezés)";
  }
} catch(e) {
  console.warn("LocalStorage nem elérhető vagy hibás:", e);
}

/* ===== LOGIN GOMB ===== */
loginBtn.addEventListener('click', () => {
  if (isLoggedIn) logout();
  else modal.style.display = 'flex';
});

/* ===== TABOK ===== */
loginTab.addEventListener('click', () => {
  formTitle.textContent = 'Bejelentkezés';
  password2.style.display = 'none';
  submitBtn.textContent = 'Belépés';
  submitBtn.onclick = login;

  loginTab.classList.add('active');
  registerTab.classList.remove('active');
});

registerTab.addEventListener('click', () => {
  formTitle.textContent = 'Regisztráció';
  password2.style.display = 'block';
  submitBtn.textContent = 'Regisztráció';
  submitBtn.onclick = register;

  registerTab.classList.add('active');
  loginTab.classList.remove('active');
});

/* ===== REGISZTRÁCIÓ (MYSQL ADATBÁZISBA) ===== */
async function register() {
  const user = username.value.trim();
  const p1 = password.value.trim();
  const p2 = password2.value.trim();

  if (!user || !p1 || !p2) return showToast('Tölts ki minden mezőt', 'error');
  if (p1 !== p2) return showToast('A jelszavak nem egyeznek', 'error');

  try {
    const response = await fetch(`${API_URL}/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: user, password: p1 })
    });

    const data = await response.json();

    if (response.ok) {
      showToast(data.message || 'Sikeres regisztráció! Most jelentkezz be.', 'success');
      password.value = '';
      password2.value = '';
      loginTab.click(); // Átvált a bejelentkezés fülre
    } else {
      showToast(data.message || 'Hiba a regisztráció során!', 'error');
    }
  } catch (error) {
    console.error('Hálózati hiba:', error);
    showToast('Nem sikerült elérni a szervert!', 'error');
  }
}

/* ===== LOGIN (MYSQL ADATBÁZISBÓL) ===== */
async function login() {
  const user = username.value.trim();
  const pass = password.value.trim();

  if (!user || !pass) return showToast('Add meg a felhasználónevet és a jelszót!', 'error');

  try {
    const response = await fetch(`${API_URL}/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: user, password: pass })
    });

    if (response.ok) {
      const data = await response.json();
      isLoggedIn = true;
      loginBtn.textContent = data.username + ' (Kijelentkezés)';
      
      // Elmentjük a munkamenetet és a szerepkört (későbbi admin felülethez)
      localStorage.setItem("isLoggedIn", "true");
      localStorage.setItem("loggedInUser", data.username);
      if (data.role) localStorage.setItem("userRole", data.role);

      showToast(data.message || 'Sikeres bejelentkezés', 'success');
      password.value = '';
      closeModal();
    } else {
      showToast('Hibás felhasználónév vagy jelszó!', 'error');
    }
  } catch (error) {
    console.error('Hálózati hiba:', error);
    showToast('Nem sikerült elérni a szervert!', 'error');
  }
}

/* ===== LOGOUT ===== */
function logout() {
  isLoggedIn = false;
  loginBtn.textContent = 'Bejelentkezés';
  localStorage.removeItem("isLoggedIn");
  localStorage.removeItem("loggedInUser");
  localStorage.removeItem("userRole");
  showToast('Kijelentkeztél', 'info');
}

/* ===== MODAL BEZÁRÁS ===== */
function closeModal() {
  modal.style.display = 'none';
}

/* Alapértelmezett regisztráció tab */
registerTab.click();
