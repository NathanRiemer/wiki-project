DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS revisions;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS article_categories;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username VARCHAR,
  password VARCHAR,
  email VARCHAR
);

CREATE TABLE articles (
  id INTEGER PRIMARY KEY,
  title VARCHAR
);

CREATE TABLE revisions (
  id INTEGER PRIMARY KEY,
  content TEXT,
  datetime_created DATETIME,
  user_id INTEGER REFERENCES users(id),
  article_id INTEGER REFERENCES articles(id)
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  body TEXT,
  datetime_created DATETIME,
  user_id INTEGER REFERENCES users(id)
);

CREATE TABLE categories (
  id INTEGER PRIMARY KEY,
  title VARCHAR
);

CREATE TABLE article_categories (
  article_id INTEGER REFERENCES articles(id),
  category_id INTEGER REFERENCES categories(id)
);