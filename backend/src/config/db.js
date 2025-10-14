const mongoose = require('mongoose');

let _dbConnected = false;

const connectDB = async () => {
  const uri = process.env.MONGODB_URI;
  if (!uri) {
    // Development convenience: don't crash the server when MONGODB_URI is missing.
    // This allows frontend UI testing (e.g. /api/ping) while you configure Atlas.
    // WARNING: this should NOT be used in production — the app will not be able to
    // access the database and DB-dependent routes will fail.
    console.warn('MONGODB_URI not set in environment — starting without DB connection (development only)');
    _dbConnected = false;
    return;
  }
  try {
    await mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });
    console.log('MongoDB connected');
    _dbConnected = true;
  } catch (err) {
    console.error('MongoDB connection error:', err.message);
    _dbConnected = false;
    process.exit(1);
  }
};

const getDbStatus = () => _dbConnected;

module.exports = connectDB;
module.exports.getDbStatus = getDbStatus;
