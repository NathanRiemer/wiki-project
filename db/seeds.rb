require_relative "config"
require "pry"

User.destroy_all
Article.destroy_all
Revision.destroy_all
Comment.destroy_all
Category.destroy_all

users = [
  {username: "nathanriemer", password: "password", email: "nathan.riemer@gmail.com", is_admin: true, city: "New York", state: "NY", country: "USA"},
  {username: "someoneelse", password: "password", email: "fake@gmail.com"}
]

User.create(users)

articles = [
  {title: "Dogs"},
  {title: "Running"},
  {title: "Welcome"}
]

Article.create(articles)

revisions = [
  {content: "Dogs are really great", created_at: DateTime.now, user_id: 1, article_id: 1},
  {content: "Dogs are *extremely* great", created_at: DateTime.now, user_id: 1, article_id: 1},
  {content: "Yay Running", created_at: DateTime.now, user_id: 1, article_id: 2},
  {content: "Welcome to Nathan Riemer's wiki project", created_at: DateTime.now, user_id: 1, article_id: 3, primary_image_url: "https://upload.wikimedia.org/wikipedia/commons/5/55/Wikipedia_logo_gold.png"}
]

Revision.create(revisions)

comments = [
  {content: "ya i love dogs", created_at: DateTime.now, user_id: 2, revision_id: 2},
  {content: "running __hurts__ my feet", created_at: DateTime.now, user_id: 2, revision_id: 3}
]

Comment.create(comments)

fitness = Category.create(title: "fitness")
animals = Category.create(title: "animals")

Article.find(1).categories.push(animals)
Article.find(2).categories.push(fitness)