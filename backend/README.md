# Syncly Backend (Express + MongoDB Atlas)

This is a minimal backend for the Syncly Flutter app.

Features:
- User registration and login (JWT)
- Projects CRUD

Quick start
1. Copy `.env.example` to `.env` and set `MONGODB_URI` and `JWT_SECRET`.
2. Install dependencies:

```powershell
cd backend
npm install
```

3. Start the server in development:

```powershell
npm run dev
```

API endpoints:
- POST /api/auth/register { name, email, password }
- POST /api/auth/login { email, password }
- GET /api/projects (requires Authorization: Bearer <token>)
- POST /api/projects (requires auth)
- GET /api/projects/:id
- PUT /api/projects/:id
- DELETE /api/projects/:id

Integrate from Flutter by calling these endpoints. Use `Authorization: Bearer <token>` header for protected routes.
# Syncly Backend (Express + MongoDB Atlas)

This is a minimal backend for the Syncly Flutter app.

Features:
- User registration and login (JWT)
- Projects CRUD

Quick start
1. Copy `.env.example` to `.env` and set `MONGODB_URI` and `JWT_SECRET`.
2. Install dependencies:

```powershell
cd backend
npm install
```

3. Start the server in development:

```powershell
npm run dev
```

API endpoints:
- POST /api/auth/register { name, email, password }
- POST /api/auth/login { email, password }
- GET /api/projects (requires Authorization: Bearer <token>)
- POST /api/projects (requires auth)
- GET /api/projects/:id
- PUT /api/projects/:id
- DELETE /api/projects/:id

Integrate from Flutter by calling these endpoints. Use `Authorization: Bearer <token>` header for protected routes.
