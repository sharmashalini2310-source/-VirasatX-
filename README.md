# VirāsatX — Interactive Heritage Journey

### Discover Heritage. Experience Stories. Learn Through Play.

**VirāsatX** is a story-driven digital heritage learning project that aims to transform cultural and historical education into an engaging interactive experience. By combining storytelling, exploration, puzzles, quizzes, and gameplay, the platform encourages users to discover cultural knowledge through participation rather than passive learning.

The project brings together four independent cultural worlds—**Cosmology, Ancient Bharat, British India, and Present India**—within a unified and expandable gaming framework.

**Team SolutionXs | Smart India Hackathon (SIH) 2026**

---

## About the Project

Cultural heritage represents an important part of India's identity, history, traditions, and knowledge. However, conventional learning methods may not always provide the interactive and immersive experiences needed to engage modern learners.

VirāsatX addresses this opportunity through a digital learning experience in which cultural narratives provide the context for exploration, challenges, and knowledge-based activities.

The platform is designed to connect heritage, storytelling, and gameplay in one accessible web-based experience.

## Problem Statement

Traditional heritage education often relies on textbooks, static information, and conventional question-and-answer formats. These approaches can limit opportunities for interactive exploration and sustained engagement.

There is a need for an adaptable digital platform that presents cultural and historical knowledge through engaging experiences while supporting the exploration of diverse cultural themes.

## Our Solution

VirāsatX combines educational content with game-inspired interactions to create a structured heritage-learning journey.

- **Narrative-based learning:** Introduces cultural and historical context through stories.
- **Interactive exploration:** Encourages discovery through themed environments and activities.
- **Puzzle-based engagement:** Connects learning content with problem-solving challenges.
- **Knowledge assessment:** Uses quizzes to reinforce understanding.
- **Structured progression:** Organizes learning activities into themes and levels.
- **Expandable framework:** Supports the planned addition of stories, languages, cultural topics, and new levels.

## Key Features

- **Four Cultural Worlds:** Separate thematic experiences within one platform.
- **Story-Driven Experience:** Connects cultural narratives with gameplay.
- **Cinematic Introductions:** Provides a narrative context before interactive activities.
- **Interactive Learning:** Encourages exploration, reasoning, and discovery.
- **Quizzes and Challenges:** Reinforces knowledge through structured activities.
- **User Authentication:** Supports registration and login workflows, with email verification where configured.
- **Progress Management:** Database structure supports level progression and answer tracking.
- **Modular Architecture:** Provides a foundation for expanding cultural content.
- **Web-Based Platform:** Uses web technologies for browser-based access.

*Feature availability depends on the implementation and configuration of the current prototype.*

## The Four Cultural Worlds

### 1. Cosmology
Explore concepts related to the cosmos, traditional worldviews, and the human understanding of the universe through a dedicated thematic experience.

### 2. Ancient Bharat
Discover ancient Indian civilizations, cultural traditions, historical narratives, and knowledge systems.

### 3. British India
Explore selected historical events, social developments, and narratives associated with India's colonial period.

### 4. Present India
Discover contemporary India's cultural diversity, identity, traditions, and continuing heritage.

Each world has its own thematic focus while remaining part of the same expandable platform.

## Gameplay Experience

**Story Introduction → World Selection → Exploration → Interaction → Puzzle Solving → Knowledge Challenge → Progression**

1. **Story Introduction:** Establishes the context of the selected cultural world.
2. **World Selection:** Allows the player to choose a thematic experience.
3. **Exploration:** Introduces the world and its cultural content.
4. **Interaction:** Encourages engagement with available story elements and activities.
5. **Puzzle Solving:** Presents challenges designed to encourage observation and reasoning.
6. **Knowledge Challenge:** Reinforces learning through questions and quizzes.
7. **Progression:** Supports advancement through available levels and activities.

## Innovation and Creativity

### Heritage → Story → Gameplay

VirāsatX connects cultural narratives directly with interactive learning activities, helping contextualize puzzles, challenges, and quests.

### Four Independent Cultural Worlds

The platform brings Cosmology, Ancient Bharat, British India, and Present India together within a single expandable framework.

### Learning Through Discovery

Rather than relying exclusively on passive reading, the concept encourages players to discover information through exploration, interaction, and problem-solving.

### Cinematic Cultural Context

Story-driven introductions establish the setting and context before players begin interactive activities.

### Expandable Heritage Framework

The architecture is designed to accommodate future cultural regions, historical periods, traditions, languages, stories, puzzles, and levels.

## Technology Stack

| Layer | Technologies |
|---|---|
| Frontend | HTML5, CSS3, JavaScript (ES6+) |
| UI Framework | Bootstrap 5 |
| Backend | Node.js, Express.js |
| Database | MySQL |
| API Communication | REST APIs, JSON, Fetch API |
| Authentication | bcryptjs, JSON Web Tokens (JWT) |
| Email Verification | OTP workflow, subject to email-service configuration |
| Version Control | Git and GitHub |
| Development Environment | Visual Studio Code, Node.js, MySQL tools |

**Additional visual-development references:** Blender, PlayCanvas, and Sketchfab. Specific 3D libraries or assets should be listed as implemented technologies only when they are actually integrated into the application.

## System Architecture

VirāsatX follows a client-server architecture that separates the user interface, application logic, and data storage.

**Frontend → REST API → Node.js / Express.js → MySQL Database**

- **Presentation Layer:** Displays authentication screens, cultural themes, stories, and gameplay interfaces.
- **Application Layer:** Processes requests and manages authentication, learning content, submissions, and progression.
- **Database Layer:** Stores users, themes, levels, questions, answer options, and user progress.
- **Communication Layer:** Transfers data between the frontend and backend through HTTP requests and JSON responses.

## Database Design

The database schema includes the following tables:

| Table | Purpose |
|---|---|
| `users` | Stores user account information |
| `themes` | Stores cultural world information |
| `levels` | Organizes learning levels |
| `questions` | Stores knowledge-assessment questions |
| `question_options` | Stores answer choices |
| `user_progress` | Tracks user-level progression |
| `user_answers` | Stores submitted answers |

The backend and frontend must use the same configured database and compatible API routes for these features to operate correctly.

## Project Structure

The following illustrates the intended organization. Refer to the repository for the exact current directory structure.

```text
-VirasatX/
├── SIH/
│   └── my-fullstack-app/
│       ├── frontend/
│       │   ├── index.html
│       │   ├── assets/
│       │   ├── css/
│       │   └── js/
│       └── backend/
│           ├── server.js
│           ├── package.json
│           ├── .env.example
│           └── database/
├── README.md
└── .gitignore
```

## Getting Started

### Prerequisites

- Node.js and npm
- MySQL database access
- Git
- Visual Studio Code or another code editor

### 1. Clone the Repository

```bash
git clone https://github.com/sharmashalini2310-source/-VirasatX.git
cd -VirasatX
```

### 2. Navigate to the Backend

If the repository uses the directory structure shown above:

```bash
cd SIH/my-fullstack-app/backend
```

Use the actual path if your backend is located elsewhere.

### 3. Install Dependencies

```bash
npm install
```

### 4. Configure Environment Variables

Create a `.env` file in the backend directory and provide the values required by your backend configuration.

```env
PORT=5000
DB_HOST=your_database_host
DB_PORT=your_database_port
DB_USER=your_database_username
DB_PASSWORD=your_database_password
DB_NAME=your_database_name
JWT_SECRET=your_long_random_secret
```

Replace the example values with your actual configuration. The database name must match the database containing the application tables.

### 5. Configure the Database

Create or select the configured MySQL database and import the project schema and seed data if available.

Verify that the required tables exist before testing registration, authentication, or progress tracking.

### 6. Start the Backend

Run the start command defined in the backend's `package.json`. If the project starts directly through `server.js`, use:

```bash
node server.js
```

The expected local backend address is:

`http://localhost:5000`

### 7. Run the Frontend

For a static HTML frontend, open a terminal in the frontend directory and run:

```bash
python -m http.server 5500
```

Open:

`http://localhost:5500`

Ensure the frontend's API base URL matches the backend address and that the backend can connect to the configured database.

*These steps are a general setup guide. Actual scripts, database settings, and directory names must match the repository.*

## Feasibility and Viability

### Technical Feasibility
- Built around widely used web technologies.
- Separates frontend, backend, and database responsibilities.
- Supports modular management of themes and learning content.
- Can be developed and tested using standard development tools.

### Educational Viability
- Encourages active engagement with cultural content.
- Combines storytelling with problem-solving and knowledge assessment.
- Has potential applications in educational and cultural learning environments.

### Scalability
- Provides a foundation for additional worlds and levels.
- Can accommodate future multilingual content and richer interactive environments.
- Can be extended for use in schools, museums, tourism, and digital education.

## Impact and Benefits

- **Cultural Awareness:** Encourages engagement with India's diverse heritage and historical narratives.
- **Interactive Learning:** Connects educational content with activities and challenges.
- **Heritage Diversity:** Provides a shared framework for presenting different cultural themes.
- **Educational Potential:** Can support students, educators, and heritage enthusiasts.
- **Future Expansion:** Offers opportunities for additional content, languages, and interactive experiences.

## Future Scope

Potential future enhancements include:

- Additional cultural worlds, historical periods, and verified stories.
- Richer interactive 3D environments and character animations.
- Multilingual narration and regional-language support.
- Enhanced achievements and learning-progress dashboards.
- Improved accessibility and mobile experiences.
- Collaboration with educational institutions and heritage organizations.

## Project Information

- **Project Name:** VirāsatX — Interactive Heritage Journey
- **Team Name:** SolutionXs
- **Competition:** Smart India Hackathon (SIH) 2026
- **Project Domain:** Cultural Heritage, Education, and Interactive Gaming

### GitHub Repository

**Repository:** [sharmashalini2310-source/-VirasatX](https://github.com/sharmashalini2310-source/-VirasatX)

**Repository Owner:** [@sharmashalini2310-source](https://github.com/sharmashalini2310-source)

The repository serves as the central location for project source code, documentation, version history, and team collaboration.

## Team Collaboration and Contributions

VirāsatX can be developed collaboratively through GitHub branches, commits, code reviews, and pull requests.

### Contribution Workflow

1. Fork the repository or obtain contributor access from the repository owner.
2. Create a separate branch for your task.
3. Make focused changes and test them locally.
4. Commit your changes with a descriptive message.
5. Push the branch and open a pull request for review.

Example:

```bash
git checkout -b feature/quiz-improvements
git add .
git commit -m "Improve quiz experience"
git push origin feature/quiz-improvements
```

Keep changes focused, follow the existing project structure, and never commit credentials or private configuration files.

## Research and References

The following resources support the project's technical research and creative direction.

- **GitHub:** https://github.com/
  - Source code hosting and team collaboration.
- **PlayCanvas:** https://playcanvas.com/
  - Reference for browser-based 3D environments and interactive gameplay.
- **Sketchfab:** https://sketchfab.com/
  - 3D asset discovery and visual references.
- **Blender:** https://www.blender.org/
  - 3D modelling and scene preparation.
- **ElevenLabs:** https://elevenlabs.io/
  - Voice generation and narration reference.
- **Motion Array:** https://motionarray.com/
  - Cinematic templates and visual storytelling references.
- **Raji: An Ancient Epic:** https://rajithegame.com/
  - Inspiration for Indian mythology, environments, and visual storytelling.

These are references and sources of inspiration, not claims of official partnerships or integration of third-party assets.

## Security and Configuration

- Keep `.env` and other secret-bearing files out of version control.
- Use `.env.example` to document required configuration variables without exposing real credentials.
- Never publish database passwords, JWT secrets, or email-service credentials.
- Use appropriate authentication, validation, and database-access controls.
- Verify third-party asset licenses before using assets in the project.

## License

A license has not yet been specified for this repository. An appropriate license should be selected and added as a `LICENSE` file before redistribution or reuse is permitted under an explicit open-source license.

---

**VirāsatX — Preserving Heritage Through Interactive Experiences.**
