# Teacher Daily Dashboard

A daily task dashboard for teachers — organize activities by grade level, subject (Computer Science / Robotics / AI Programming), priority, and curriculum (IGCSE / IB MYP / IB DP).

Built as a single-page static site. Works offline with browser storage, and optionally syncs to your Google Drive so the same tasks appear on every device you sign in on.

## Features

- **Big live clock and date** at the top so you always know where you are in the day
- **Personalized welcome** with your name and time-of-day greeting
- Add, edit, complete, prioritize and delete activities
- Filter by view (Today / Upcoming / Overdue / All / Completed), grade, and subject
- Search across titles and notes
- 5 live counters: Today, High Priority, Overdue, Done Today, Open Tasks
- **News Corner** — Tech-AI, Tech-General, Programming, Robotics, Education, Science, or custom keywords. Pulled from Hacker News, no signup
- **Light and Dark themes** plus system-follows-OS option
- **Customizable categories** — add or remove your own grades, subjects, and boards from Settings
- Optional Google Drive sync — same data on every device
- Local backup: export / import as JSON (settings included)
- No backend required — runs as a static page on GitHub Pages

## Settings

Click ⚙ Settings in the top right to open a tabbed panel:

- **Profile** — your display name (used in the welcome greeting)
- **Categories** — manage grades/departments, subjects, and boards/curricula. Add as many as you like.
- **News** — pick a preset topic or enter custom Hacker News keywords; choose auto-refresh interval
- **Theme** — Light, Dark, or System (follows your OS)
- **Drive Sync** — paste your Google OAuth Client ID to enable cross-device sync

---

## Folder structure

```
teacher-dashboard/
├── index.html           ← the whole dashboard (self-contained)
├── data/
│   └── dashboard.json   ← your tasks + settings (read/written by the app)
├── README.md
├── publish-to-github.ps1
└── .gitignore
```

The `data/dashboard.json` file is the single source of truth in "Local folder" mode. Copy the whole `teacher-dashboard/` folder anywhere — your data goes with it.

## Three storage modes

Open **Settings → Storage** in the dashboard and pick one:

1. **💾 Browser only** — tasks live in localStorage on this device, per-browser. Fastest, zero setup. Default.
2. **📁 Local folder** — pick a folder once (typically this `teacher-dashboard/` folder); the dashboard reads and writes `data/dashboard.json` there. Copy the folder to USB / OneDrive / Dropbox / etc. for portable use. Requires Chrome, Edge, or Brave.
3. **☁️ Google Drive** — cross-device sync via your Drive account. Works in any browser.

## Quick start

1. Open `index.html` in a browser (double-click, or drag it into Chrome/Edge).
2. The dashboard loads seed tasks from `data/dashboard.json`.
3. To make edits persist to the JSON file: open **Settings → Storage**, choose **Local folder**, click **Pick folder**, and pick this `teacher-dashboard/` folder. Done — auto-saves to `data/dashboard.json` from then on.

---

## Deploy to GitHub Pages (5 minutes)

1. **Create a new repo** on github.com named `teacher-dashboard`. Leave it public; do not initialize with a README (you already have one).

2. **Push these files** from the project folder:

   ```bash
   cd "F:\ClaudeCo-work\teacher-dashboard"
   git init
   git add .
   git commit -m "Initial dashboard"
   git branch -M main
   git remote add origin https://github.com/<YOUR-USERNAME>/teacher-dashboard.git
   git push -u origin main
   ```

   Replace `<YOUR-USERNAME>` with your GitHub username.

3. **Enable GitHub Pages**: in the repo, go to **Settings → Pages**. Under "Build and deployment", set Source to **Deploy from a branch**, Branch = `main`, Folder = `/ (root)`. Save.

4. Wait ~1 minute, then open `https://<YOUR-USERNAME>.github.io/teacher-dashboard/` in your browser. The dashboard will load with a setup screen.

---

## Enable Google Drive sync (one-time, ~10 minutes)

This step is **optional**. Skip it if you only want browser storage.

### Step 1 — Get a Google OAuth Client ID

1. Open [Google Cloud Console → Credentials](https://console.cloud.google.com/apis/credentials). Sign in with the Google account you want to sync with (e.g. `pcshiva@gmail.com`).

2. Create a new project if you don't have one. Any name works (e.g. "Teacher Dashboard").

3. **Enable the Google Drive API**: open [this link](https://console.cloud.google.com/apis/library/drive.googleapis.com) → click **Enable**.

4. **OAuth consent screen** (left sidebar): set User Type = **External** → Create. Fill in app name (e.g. "Teacher Dashboard"), your email, and developer contact email. Save and continue through the remaining screens (you can leave Scopes empty here). Under "Test users", add your own Gmail address. Back to Dashboard.

5. **Credentials → Create credentials → OAuth client ID**:
   - Application type: **Web application**
   - Name: anything (e.g. "Dashboard Web Client")
   - Authorized JavaScript origins: add `https://<YOUR-USERNAME>.github.io` (no path, no trailing slash). Also add `http://localhost` if you want to test locally.
   - Authorized redirect URIs: leave blank — we're using the Google Identity Services token flow, not redirect flow.
   - Create.

6. A dialog shows your **Client ID**, looking like `123456789-abc...apps.googleusercontent.com`. Copy it.

### Step 2 — Configure the dashboard

1. Open your live dashboard URL (`https://<YOUR-USERNAME>.github.io/teacher-dashboard/`).

2. On the setup screen, paste the Client ID and click **Save & continue**.

3. Click **🔐 Sign in to Drive** in the top right. Google prompts you to authorize "Teacher Dashboard" → click Allow.

4. The dashboard creates a `Teacher Dashboard` folder in your Drive (root level) and saves a JSON snapshot of your tasks there. Every change saves a new snapshot (auto-debounced 4 seconds).

5. Open the same URL on another device, sign in with the same Google account → your tasks appear.

---

## How sync works

- The dashboard uses the `drive.file` scope, which only allows it to see / modify files it created itself. It cannot read your other Drive files.
- Each save creates a new timestamped JSON file in your `Teacher Dashboard` folder (e.g. `tasks-2026-05-10T14-32-00-000Z.json`). The latest by creation time is treated as the current state.
- This append-only pattern means you get free version history — you can open any older snapshot in Drive to recover deleted tasks.
- Cleanup: open the `Teacher Dashboard` folder in Drive monthly and delete older snapshots if it gets crowded. Th