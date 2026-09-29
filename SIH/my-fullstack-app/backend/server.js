// =========================================================
// VIRASATX NODE.JS / EXPRESS BACKEND (FIXED)
// =========================================================
// Install:
// npm install express mysql2 cors bcryptjs dotenv jsonwebtoken
//
// Start:
// node server.js
// =========================================================

require("dotenv").config();

const express = require("express");
const mysql = require("mysql2/promise");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();
const PORT = process.env.PORT || 5000;
const JWT_SECRET = process.env.JWT_SECRET || "change-this-to-a-long-random-secret";

// -------------------- MIDDLEWARE --------------------
app.use(cors());
app.use(express.json());

// -------------------- MYSQL POOL --------------------
const db = mysql.createPool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,

  ssl: {
    rejectUnauthorized: false
  },

  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// -------------------- AUTH MIDDLEWARE --------------------
function authenticate(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({
      success: false,
      message: "Authentication required.",
    });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded; // { id, email, name }
    next();
  } catch (err) {
    return res.status(401).json({
      success: false,
      message: "Invalid or expired token.",
    });
  }
}

// -------------------- DATABASE TEST --------------------
app.get("/", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT 1 AS connected");
    res.json({
      success: true,
      message: "VirāsatX Node.js + MySQL backend is running.",
      database: rows[0].connected === 1,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: "Database connection failed." });
  }
});

// -------------------- REGISTER --------------------
app.post("/api/register", async (req, res) => {
  const connection = await db.getConnection();

  try {
    const { name, email, password } = req.body;

    // Basic validation
    if (!name || !email || !password) {
      return res.status(400).json({
        success: false,
        message: "Name, email and password are required.",
      });
    }

    if (name.trim().length < 2) {
      return res.status(400).json({
        success: false,
        message: "Name must be at least 2 characters.",
      });
    }

    if (password.length < 6) {
      return res.status(400).json({
        success: false,
        message: "Password must be at least 6 characters.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();

    // Simple email check
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(normalizedEmail)) {
      return res.status(400).json({
        success: false,
        message: "Invalid email address.",
      });
    }

    await connection.beginTransaction();

    // Check if email already exists
    const [existing] = await connection.query(
      "SELECT id FROM users WHERE email = ?",
      [normalizedEmail]
    );

    if (existing.length > 0) {
      await connection.rollback();
      return res.status(409).json({
        success: false,
        message: "An account with this email already exists.",
      });
    }

    const passwordHash = await bcrypt.hash(password, 12);

    const [result] = await connection.query(
      `INSERT INTO users (full_name, email, password_hash)
       VALUES (?, ?, ?)`,
      [name.trim(), normalizedEmail, passwordHash]
    );

    const userId = result.insertId;

    // Create progress records for every level
    const [levels] = await connection.query(
      `SELECT l.id, l.theme_id, l.level_number
       FROM levels l
       ORDER BY l.theme_id, l.level_number`
    );

    if (levels.length > 0) {
      const progressValues = levels.map((level) => [
        userId,
        level.theme_id,
        level.id,
        level.level_number === 1 ? "available" : "locked",
      ]);

      await connection.query(
        `INSERT INTO user_progress
         (user_id, theme_id, level_id, status)
         VALUES ?`,
        [progressValues]
      );
    }

    await connection.commit();

    // Generate JWT
    const token = jwt.sign(
      {
        id: userId,
        email: normalizedEmail,
        name: name.trim(),
      },
      JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.status(201).json({
      success: true,
      message: "Account created successfully.",
      token,
      user: {
        id: userId,
        name: name.trim(),
        email: normalizedEmail,
      },
    });
  } catch (error) {
    await connection.rollback();
    console.error("REGISTER ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Server error during registration.",
    });
  } finally {
    connection.release();
  }
});

// -------------------- LOGIN --------------------
app.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Email and password are required.",
      });
    }

    const normalizedEmail = email.trim().toLowerCase();

    const [rows] = await db.query(
      `SELECT id, full_name, email, password_hash, email_verified
       FROM users
       WHERE email = ?`,
      [normalizedEmail]
    );

    if (rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    const user = rows[0];

    const passwordOK = await bcrypt.compare(password, user.password_hash);

    if (!passwordOK) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
        name: user.full_name,
      },
      JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({
      success: true,
      message: "Login successful.",
      token,
      user: {
        id: user.id,
        name: user.full_name,
        email: user.email,
        emailVerified: !!user.email_verified,
      },
    });
  } catch (error) {
    console.error("LOGIN ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Server error during login.",
    });
  }
});

// -------------------- VERIFY EMAIL (protected) --------------------
app.post("/api/users/verify-email", authenticate, async (req, res) => {
  try {
    // Only allow the logged-in user to verify their own email
    const email = req.user.email;

    const [result] = await db.query(
      `UPDATE users
       SET email_verified = TRUE
       WHERE email = ?`,
      [email]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found.",
      });
    }

    res.json({
      success: true,
      message: "Email marked as verified.",
    });
  } catch (error) {
    console.error("VERIFY ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Server error.",
    });
  }
});

// -------------------- GET THEMES --------------------
app.get("/api/themes", async (req, res) => {
  try {
    const [themes] = await db.query(
      `SELECT id, theme_name, theme_code, description,
              image_path, video_path, display_order
       FROM themes
       WHERE is_active = TRUE
       ORDER BY display_order`
    );

    res.json({
      success: true,
      themes,
    });
  } catch (error) {
    console.error("THEMES ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Could not load themes.",
    });
  }
});

// -------------------- GET LEVELS FOR A THEME --------------------
app.get("/api/themes/:themeId/levels", async (req, res) => {
  try {
    const themeId = Number(req.params.themeId);

    if (!Number.isInteger(themeId) || themeId <= 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid theme ID.",
      });
    }

    const [levels] = await db.query(
      `SELECT id, theme_id, level_number, level_name,
              description, difficulty, intro_text, reward_points
       FROM levels
       WHERE theme_id = ?
       ORDER BY level_number`,
      [themeId]
    );

    res.json({
      success: true,
      levels,
    });
  } catch (error) {
    console.error("LEVELS ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Could not load levels.",
    });
  }
});

// -------------------- GET USER PROGRESS (protected) --------------------
app.get("/api/users/:userId/progress", authenticate, async (req, res) => {
  try {
    const userId = Number(req.params.userId);

    // Security: user can only request their own progress
    if (userId !== req.user.id) {
      return res.status(403).json({
        success: false,
        message: "You can only view your own progress.",
      });
    }

    const [progress] = await db.query(
      `SELECT
          up.level_id,
          up.theme_id,
          up.status,
          up.score,
          up.total_questions,
          up.correct_answers,
          up.attempts,
          up.completed_at,
          l.level_number,
          l.level_name,
          l.difficulty,
          l.reward_points,
          t.theme_name
       FROM user_progress up
       JOIN levels l ON l.id = up.level_id
       JOIN themes t ON t.id = up.theme_id
       WHERE up.user_id = ?
       ORDER BY t.display_order, l.level_number`,
      [userId]
    );

    res.json({
      success: true,
      progress,
    });
  } catch (error) {
    console.error("PROGRESS ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Could not load progress.",
    });
  }
});

// -------------------- GET QUESTIONS FOR A LEVEL --------------------
// Correct answers are NEVER returned to the frontend.
app.get("/api/levels/:levelId/questions", async (req, res) => {
  try {
    const levelId = Number(req.params.levelId);

    if (!Number.isInteger(levelId) || levelId <= 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid level ID.",
      });
    }

    const [questions] = await db.query(
      `SELECT
          q.id,
          q.question_text,
          q.question_type,
          q.points,
          q.question_order,
          qo.id AS option_id,
          qo.option_key,
          qo.option_text
       FROM questions q
       JOIN question_options qo ON qo.question_id = q.id
       WHERE q.level_id = ?
       ORDER BY q.question_order, qo.option_key`,
      [levelId]
    );

    const grouped = {};

    for (const row of questions) {
      if (!grouped[row.id]) {
        grouped[row.id] = {
          id: row.id,
          question_text: row.question_text,
          question_type: row.question_type,
          points: row.points,
          question_order: row.question_order,
          options: [],
        };
      }

      grouped[row.id].options.push({
        id: row.option_id,
        key: row.option_key,
        text: row.option_text,
      });
    }

    res.json({
      success: true,
      questions: Object.values(grouped),
    });
  } catch (error) {
    console.error("QUESTIONS ERROR:", error);
    res.status(500).json({
      success: false,
      message: "Could not load questions.",
    });
  }
});

// -------------------- SUBMIT LEVEL (protected) --------------------
app.post("/api/levels/:levelId/submit", authenticate, async (req, res) => {
  const connection = await db.getConnection();

  try {
    const levelId = Number(req.params.levelId);
    const { answers } = req.body;
    const userId = req.user.id; // Always take from token, never from body

    if (!Number.isInteger(levelId) || levelId <= 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid level ID.",
      });
    }

    if (!Array.isArray(answers)) {
      return res.status(400).json({
        success: false,
        message: "answers must be an array.",
      });
    }

    await connection.beginTransaction();

    // 1. Check that this level is available (or already completed) for the user
    const [progressRows] = await connection.query(
      `SELECT status FROM user_progress
       WHERE user_id = ? AND level_id = ?`,
      [userId, levelId]
    );

    if (progressRows.length === 0) {
      await connection.rollback();
      return res.status(404).json({
        success: false,
        message: "Progress record not found for this level.",
      });
    }

    const currentStatus = progressRows[0].status;

    if (currentStatus === "locked") {
      await connection.rollback();
      return res.status(403).json({
        success: false,
        message: "This level is still locked.",
      });
    }

    // 2. Get correct answers
    const [questions] = await connection.query(
      `SELECT q.id, q.points, qo.id AS correct_option_id
       FROM questions q
       JOIN question_options qo
         ON qo.question_id = q.id
        AND qo.is_correct = TRUE
       WHERE q.level_id = ?`,
      [levelId]
    );

    let score = 0;
    let correctCount = 0;

    // Optional: clear previous answers for this user+level if you allow retries
    await connection.query(
      `DELETE FROM user_answers
       WHERE user_id = ? AND level_id = ?`,
      [userId, levelId]
    );

    for (const answer of answers) {
      const question = questions.find(
        (q) => q.id === Number(answer.questionId)
      );

      if (!question) continue;

      const selectedOptionId = Number(answer.optionId);
      const isCorrect =
        selectedOptionId === Number(question.correct_option_id);

      const points = isCorrect ? question.points : 0;

      if (isCorrect) {
        correctCount++;
        score += points;
      }

      await connection.query(
        `INSERT INTO user_answers
         (user_id, level_id, question_id, selected_option_id,
          is_correct, points_earned)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [
          userId,
          levelId,
          question.id,
          selectedOptionId || null,
          isCorrect,
          points,
        ]
      );
    }

    const totalQuestions = questions.length;

    // 3. Update progress
    await connection.query(
      `UPDATE user_progress
       SET status = 'completed',
           score = ?,
           total_questions = ?,
           correct_answers = ?,
           attempts = attempts + 1,
           completed_at = NOW()
       WHERE user_id = ? AND level_id = ?`,
      [score, totalQuestions, correctCount, userId, levelId]
    );

    // 4. Unlock the next level in the SAME theme
    const [currentLevel] = await connection.query(
      `SELECT theme_id, level_number
       FROM levels
       WHERE id = ?`,
      [levelId]
    );

    if (currentLevel.length > 0) {
      const themeId = currentLevel[0].theme_id;
      const currentNumber = currentLevel[0].level_number;

      await connection.query(
        `UPDATE user_progress up
         JOIN levels l ON l.id = up.level_id
         SET up.status = 'available'
         WHERE up.user_id = ?
           AND l.theme_id = ?
           AND l.level_number = ?
           AND up.status = 'locked'`,
        [userId, themeId, currentNumber + 1]
      );
    }

    await connection.commit();

    res.json({
      success: true,
      result: {
        score,
        totalQuestions,
        correctAnswers: correctCount,
        percentage: totalQuestions
          ? Math.round((correctCount / totalQuestions) * 100)
          : 0,
      },
    });
  } catch (error) {
    await connection.rollback();
    console.error("SUBMIT ERROR:", error);

    res.status(500).json({
      success: false,
      message: "Could not submit level.",
    });
  } finally {
    connection.release();
  }
});

// -------------------- START SERVER --------------------
app.listen(PORT, () => {
  console.log(`VirāsatX server running at http://localhost:${PORT}`);
});