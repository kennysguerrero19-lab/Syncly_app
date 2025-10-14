require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');
const { getDbStatus } = require('./config/db');

const app = express();
app.use(cors());
app.use(express.json());

// Debug: show env values (mask sensitive parts)
const envPort = process.env.PORT;
console.log('Starting server - process.env.PORT =', envPort ? envPort : '(not set)');
console.log('MONGODB_URI present?', !!process.env.MONGODB_URI);

// Connect DB
connectDB();

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/projects', require('./routes/projects'));
// Ping for quick test
app.get('/api/ping', (req, res) => res.json({ ok: true, dbConnected: getDbStatus() }));

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
