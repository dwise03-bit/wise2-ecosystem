-- WISE² Database Schema (PostgreSQL)

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  api_key VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE prompts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  name VARCHAR(255),
  content TEXT,
  category VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE portfolios (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  name VARCHAR(255),
  total_value DECIMAL(12, 2),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE models (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  name VARCHAR(255),
  file_type VARCHAR(10),
  vertices INTEGER,
  triangles INTEGER,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_prompts_user ON prompts(user_id);
CREATE INDEX idx_models_user ON models(user_id);
