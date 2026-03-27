# mysql-team-project

Database project with a Node/Express web app in `webapp/`.

## Azure App Service Setup

This repo is prepared for Azure App Service on Linux:

- The app listens on `process.env.PORT`.
- The server binds to `0.0.0.0`.
- Root `package.json` starts the real app from `webapp/`.
- A health endpoint is available at `/health`.

### Azure Portal Settings

- Stack: `Node`
- Version: `Node 24 LTS`
- Startup Command: leave blank, or set `npm start`

### Required App Settings

Set these in Azure App Service under Environment Variables:

- `DB_HOST`
- `DB_PORT`
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`
- `DB_SSL`
- `SESSION_SECRET`
- `NODE_ENV=production`

Notes:

- Do not rely on `webapp/.env` in Azure. Use App Service environment variables.
- Set `DB_SSL=true` if your MySQL server requires SSL.
- `SESSION_SECRET` should be a long random string.

### Health Check

If you enable Health Check in Azure, use:

- `/health`
