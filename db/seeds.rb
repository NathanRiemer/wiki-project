require_relative "config"
require "pry"

User.destroy_all
Article.destroy_all
Revision.destroy_all
Comment.destroy_all
Category.destroy_all

users = [
  {username: "nathanriemer", password: "pass", email: "nathan.riemer@gmail.com"},
  {username: "someoneelse", password: "pass", email: "fake@gmail.com"}
]

User.create(users)

articles = [
  {title: "Dogs"},
  {title: "Running"}
]

Article.create(articles)

revisions = [
  {content: "Dogs are really great", created_at: DateTime.now, user_id: 1, article_id: 1},
  {content: "Dogs are extremely great", created_at: DateTime.now, user_id: 1, article_id: 1},
  {content: "Yay Running", created_at: DateTime.now, user_id: 1, article_id: 2}
]

Revision.create(revisions)

comments = [
  {content: "ya i love dogs", created_at: DateTime.now, user_id: 2, revision_id: 2},
  {content: "running hurts my feet", created_at: DateTime.now, user_id: 2, revision_id: 3}
]

Comment.create(comments)

fitness = Category.create(title: "fitness")
animals = Category.create(title: "animals")

Article.find(1).categories.push(fitness)
Article.find(2).categories.push(animals)