DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS revisions;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS articles_categories;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username VARCHAR,
  password_digest VARCHAR,
  email VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  avatar_image_url VARCHAR,
  city VARCHAR,
  state VARCHAR,
  country VARCHAR
);

CREATE TABLE articles (
  id INTEGER PRIMARY KEY,
  title VARCHAR
);

CREATE TABLE revisions (
  id INTEGER PRIMARY KEY,
  content TEXT,
  created_at DATETIME,
  user_id INTEGER REFERENCES users(id),
  article_id INTEGER REFERENCES articles(id)
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  content TEXT,
  created_at DATETIME,
  user_id INTEGER REFERENCES users(id),
  revision_id INTEGER REFERENCES revisions(id)
);

CREATE TABLE categories (
  id INTEGER PRIMARY KEY,
  title VARCHAR
);

CREATE TABLE articles_categories (
  article_id INTEGER REFERENCES articles(id),
  category_id INTEGER REFERENCES categories(id)
);