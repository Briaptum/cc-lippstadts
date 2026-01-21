# cc-lippstadt

Cavalry Chapel Lippstadt - Full-stack site with a Go + Gin + GORM backend and a Vue 3 + Vite frontend.

## Quick start

```bash
# Start everything (auto-copies env.example to .env if missing)
make up

# Stop everything
make stop
```

## Services (local)
- Frontend: http://localhost:3000
- Backend API: http://localhost:8080
- MailHog (SMTP capture): http://localhost:8025

## Tech stack
- Backend: Go 1.22, Gin, GORM, PostgreSQL
- Frontend: Vue 3, Vite, Tailwind (via @tailwindcss/vite)
- Dev infra: Docker & Docker Compose
