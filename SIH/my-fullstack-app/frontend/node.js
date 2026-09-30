// =========================================================
// VIRASATX FRONTEND API CONNECTION
// Replace the current login/signup/OTP completion logic with
// these functions. Keep your existing UI/CSS.
// =========================================================

const API_BASE = "https://virasatx.onrender.com";

// Stores the logged-in user's database ID.
let currentUserId = null;

// -------------------- REGISTER --------------------
signupBtn.addEventListener("click", async () => {

    const name = nameInput.value.trim();
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();

    if (!name || !email || !password) {
        showToast("Fill all fields");
        return;
    }

    try {

        await registerUser(name, email, password);

        currentEmail = email;

        await sendOTP(email);

    } catch (err) {

        console.error(err);
        showToast(err.message);

    }

});

// -------------------- LOGIN --------------------
loginBtn.addEventListener("click", async () => {

    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();

    if (!email || !password) {
        showToast("Enter email and password");
        return;
    }

    try {

        const result = await loginUser(email, password);

        showToast("Login successful ✦");

        localStorage.setItem("virasatxUserId", result.user.id);
        localStorage.setItem("virasatxEmail", result.user.email);
        localStorage.setItem("virasatxName", result.user.name);

        themeScreen.classList.add("active");
        loginScreen.classList.remove("active");

    } catch (err) {

        console.error(err);
        showToast(err.message);

    }

});

// -------------------- VERIFY EMAIL IN DATABASE --------------------
verifyOtpBtn.addEventListener("click", async () => {

    let entered = "";

    otpInputs.forEach(input => {
        entered += input.value;
    });

    if (entered.length !== 6) {
        showToast("Enter complete OTP");
        return;
    }

    if (entered !== generatedOTP) {
        showToast("Invalid OTP");
        return;
    }

    try {

        await markEmailVerified(currentEmail);

        showToast("Email verified successfully");

        otpScreen.classList.remove("active");
        themeScreen.classList.add("active");

    } catch (err) {

        console.error(err);
        showToast(err.message);
    }

});

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
