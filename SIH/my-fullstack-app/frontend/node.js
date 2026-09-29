// =========================================================
// VIRASATX FRONTEND API CONNECTION
// Replace the current login/signup/OTP completion logic with
// these functions. Keep your existing UI/CSS.
// =========================================================

const API_BASE = "http://localhost:5000";

// Stores the logged-in user's database ID.
let currentUserId = null;

// -------------------- REGISTER --------------------
async function registerUser(name, email, password) {
    const response = await fetch(`${API_BASE}/api/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name, email, password })
    });

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Registration failed.");
    }

    currentUserId = data.user.id;
    localStorage.setItem("virasatxUserId", data.user.id);
    localStorage.setItem("virasatxEmail", data.user.email);

    return data;
}

// -------------------- LOGIN --------------------
async function loginUser(email, password) {
    const response = await fetch(`${API_BASE}/api/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password })
    });

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Login failed.");
    }

    currentUserId = data.user.id;

    localStorage.setItem("virasatxUserId", data.user.id);
    localStorage.setItem("virasatxEmail", data.user.email);
    localStorage.setItem("virasatxName", data.user.name);

    return data;
}

// -------------------- VERIFY EMAIL IN DATABASE --------------------
async function markEmailVerified(email) {
    const response = await fetch(`${API_BASE}/api/users/verify-email`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email })
    });

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Verification failed.");
    }

    return data;
}

// -------------------- LOAD THEMES --------------------
async function loadThemesFromDatabase() {
    const response = await fetch(`${API_BASE}/api/themes`);
    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Could not load themes.");
    }

    return data.themes;
}

// -------------------- LOAD LEVELS --------------------
async function loadLevels(themeId) {
    const response = await fetch(
        `${API_BASE}/api/themes/${themeId}/levels`
    );

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Could not load levels.");
    }

    return data.levels;
}

// -------------------- LOAD QUESTIONS --------------------
async function loadQuestions(levelId) {
    const response = await fetch(
        `${API_BASE}/api/levels/${levelId}/questions`
    );

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Could not load questions.");
    }

    return data.questions;
}

// -------------------- SUBMIT LEVEL --------------------
async function submitLevel(levelId, answers) {
    const userId = Number(
        localStorage.getItem("virasatxUserId")
    );

    if (!userId) {
        throw new Error("User is not logged in.");
    }

    const response = await fetch(
        `${API_BASE}/api/levels/${levelId}/submit`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                userId,
                answers
            })
        }
    );

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Could not submit level.");
    }

    return data.result;
}

// -------------------- LOAD USER PROGRESS --------------------
async function loadUserProgress() {
    const userId = Number(
        localStorage.getItem("virasatxUserId")
    );

    if (!userId) {
        throw new Error("User is not logged in.");
    }

    const response = await fetch(
        `${API_BASE}/api/users/${userId}/progress`
    );

    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || "Could not load progress.");
    }

    return data.progress;
}

// -------------------- BACKEND TEST --------------------
async function testBackendConnection() {
    try {
        const response = await fetch(`${API_BASE}/`);

        if (!response.ok) {
            throw new Error("Backend response error");
        }

        const data = await response.json();
        console.log("Connected:", data);
        return true;

    } catch (error) {
        console.error("Backend connection failed:", error);
        showToast("Node.js server is not connected.");
        return false;
    }
}

testBackendConnection();
