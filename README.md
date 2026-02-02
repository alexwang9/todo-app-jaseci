# Name: Alex Wang, UMID: 96559954

# TaskFlow

An AI-powered todo application built with Jac, featuring intelligent task management, automatic priority detection, and meal planning capabilities.

## Features

- **User Authentication** - Secure signup/login with session management
- **AI Task Categorization** - Automatically categorizes todos (WORK, PERSONAL, SHOPPING, HEALTH, OTHER)
- **Priority Intelligence** - AI-powered automatic priority detection (HIGH/MEDIUM/LOW)
- **Effort Estimation** - Intelligent effort prediction (QUICK/MODERATE/SIGNIFICANT)
- **Task Breakdown** - Break complex tasks into subtasks using AI
- **Meal Planning** - AI-generated shopping lists with cost estimates
- **Dark Mode UI** - Modern, responsive interface with color-coded badges

## Project Structure

```
my-todo/
├── jac.toml                    # Project configuration
├── main.jac                    # Backend logic: walkers, AI functions, data models
├── frontend.cl.jac             # Frontend component declarations
├── frontend.impl.jac           # Frontend method implementations
├── styles.css                  # Application styling
├── components/                 # Reusable components
│   ├── TodoItem.cl.jac        # Todo item with priority/effort badges and subtasks
│   ├── AuthForm.cl.jac        # Login/signup form
│   └── IngredientItem.cl.jac  # Meal planner ingredient display
├── assets/                     # Static assets
└── .jac/                       # Build output (generated)
```

## Installation and Setup

### Prerequisites

- **Jac** - Install the Jac language runtime
- **Node.js** - Required for client-side dependencies (v18 or higher recommended)
- **Anthropic API Key** - Required for AI features (priority detection, task breakdown, etc.)

### Installation Steps

1. **Clone or navigate to the project directory:**
   ```bash
   cd /path/to/my-todo
   ```

2. **Install dependencies:**
   ```bash
   jac install
   ```
   This will install both Jac dependencies and npm packages for the client-side components.

3. **Set up your Anthropic API key:**

   The application uses Claude AI for task categorization, priority detection, and task breakdown. You need to set your Anthropic API key as an environment variable:

   ```bash
   export ANTHROPIC_API_KEY="your-api-key-here"
   ```

   Or create a `.env` file in the project root:
   ```
   ANTHROPIC_API_KEY=your-api-key-here
   ```

4. **Start the development server:**
   ```bash
   jac start main.jac
   ```

5. **Access the application:**

   Open your browser and navigate to the URL shown in the terminal (typically `http://localhost:8000`)

### First-Time Usage

1. Click "Sign up here" to create a new account
2. Enter a username and password (minimum 4 characters)
3. Once logged in, you can:
   - Add todos (they'll automatically get priority and effort estimates)
   - Click the 💡 button on any task to break it down into subtasks
   - Use the meal planner to generate shopping lists

## Custom Features

### Feature 1: AI-Powered Task Breakdown

**Description:** This feature uses Claude AI to intelligently break down complex tasks into 3-5 actionable subtasks. When users create a task like "Plan team offsite," they can click the 💡 button to automatically generate subtasks such as "Book venue," "Send calendar invites," "Prepare agenda," etc.

**How it works:**
- When a user clicks the breakdown button, the `BreakDownTask` walker (main.jac:138-154) is spawned
- The walker calls the `break_down_task()` LLM function (main.jac:39), which uses Claude to analyze the task title and generate relevant subtasks
- Subtasks are stored as a list in the Todo node's `subtasks` field (main.jac:48)
- The frontend displays subtasks in an indented container (components/TodoItem.cl.jac:57-71) with individual checkboxes
- Users can toggle subtask completion via the `ToggleSubtask` walker (main.jac:156-176)

**Relevant code locations:**
- AI function: `main.jac:39`
- Data model: `main.jac:27-30` (Subtask object), `main.jac:48` (subtasks field)
- Backend walker: `main.jac:138-176` (BreakDownTask and ToggleSubtask walkers)
- Frontend logic: `frontend.impl.jac:45-77` (breakDownTask and toggleSubtask methods)
- UI component: `components/TodoItem.cl.jac:57-71` (subtasks display)
- Styling: `styles.css:77-88` (subtask styles)

### Feature 2: Priority Intelligence System

**Description:** This feature automatically analyzes task titles and assigns priority levels (HIGH/MEDIUM/LOW) and effort estimates (QUICK/MODERATE/SIGNIFICANT). Tasks like "Submit tax return" get HIGH priority, while "Organize desk" gets LOW priority. Each task displays color-coded badges showing its priority and estimated effort.

**How it works:**
- When a user creates a new todo, the `AddTodo` walker automatically calls two AI functions:
  - `suggest_priority()` (main.jac:41) - analyzes the task title for urgency indicators (deadlines, critical keywords)
  - `estimate_effort()` (main.jac:43) - estimates time/complexity based on task description
- Priority and effort are stored directly in the Todo node (main.jac:46-47)
- The TodoItem component displays color-coded badges (components/TodoItem.cl.jac:27-38):
  - **HIGH** priority appears in red
  - **MEDIUM** priority appears in yellow
  - **LOW** priority appears in green
  - Effort badges use purple/blue/pink color scheme
- This helps users quickly prioritize their workload at a glance

**Relevant code locations:**
- AI functions: `main.jac:41-43` (suggest_priority and estimate_effort)
- Data model: `main.jac:19-21` (Priority and Effort enums), `main.jac:46-47` (Todo fields)
- Backend logic: `main.jac:64-66` (AI calls in AddTodo walker)
- Frontend display: `components/TodoItem.cl.jac:27-38` (badge rendering)
- Styling: `styles.css:28-44` (priority and effort badge styles with color coding)

## Components

Create Jac components in `components/` as `.cl.jac` files and import them:

```jac
cl import from .components.Button { Button }
```

## Adding Dependencies

Add npm packages with the --cl flag:

```bash
jac add --cl react-router-dom
```
