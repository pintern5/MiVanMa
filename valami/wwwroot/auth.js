let isLoggedIn = false;
let registeredUser = null;

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

try {
  const storedUser = localStorage.getItem("registeredUser");
  if (storedUser) registeredUser = JSON.parse(storedUser);

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


/* ===== LOGIN GOMB ===== */
loginBtn.addEventListener('click', () => {
  if (isLoggedIn) logout();
  else modal.style.display = 'flex';
});

/* TABOK */
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

/* ===== REGISZTRÁCIÓ ===== */
function register() {
  const user = username.value.trim();
  const p1 = password.value.trim();
  const p2 = password2.value.trim();

  if (!user || !p1 || !p2) return showToast('Tölts ki minden mezőt', 'error');
  if (p1 !== p2) return showToast('A jelszavak nem egyeznek', 'error');

  registeredUser = { username: user, password: p1 };
  localStorage.setItem("registeredUser", JSON.stringify(registeredUser)); // mentés

  showToast('Sikeres regisztráció! Most jelentkezz be.', 'success');
  loginTab.click();
}

/* ===== LOGIN ===== */
function login() {
  const user = username.value.trim();
  const pass = password.value.trim();

  if (!registeredUser) return showToast('Először regisztrálj!', 'error');

  if (user === registeredUser.username && pass === registeredUser.password) {
    isLoggedIn = true;
    loginBtn.textContent = user + ' (Kijelentkezés)';
    localStorage.setItem("isLoggedIn", true);       // mentés
    localStorage.setItem("loggedInUser", user);       // mentés

    showToast('Sikeres bejelentkezés', 'success');
    closeModal();
  } else showToast('Hibás adatok', 'error');
}

/* ===== LOGOUT ===== */
function logout() {
  isLoggedIn = false;
  loginBtn.textContent = 'Bejelentkezés';
  localStorage.removeItem("isLoggedIn");
  localStorage.removeItem("loggedInUser");
  showToast('Kijelentkeztél', 'info');
}

/* ===== MODAL BEZÁRÁS ===== */
function closeModal() {
  modal.style.display = 'none';
}

/* Alapértelmezett regisztráció tab */
registerTab.click();

