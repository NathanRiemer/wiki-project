require_relative "config"

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
  {content: "Dogs are really great", created_at: DateTime.now, user_id: User.find_by(username: "nathanriemer").id, article_id: Article.find_by(title: "Dogs").id},
  {content: "Dogs are *extremely* great", created_at: DateTime.now, user_id: User.find_by(username: "nathanriemer").id, article_id: Article.find_by(title: "Dogs").id},
  {content: "Yay Running", created_at: DateTime.now, user_id: User.find_by(username: "nathanriemer").id, article_id: Article.find_by(title: "Running").id},
  {content: "Welcome to Nathan Riemer's wiki project", created_at: DateTime.now, user_id: User.find_by(username: "nathanriemer").id, article_id: Article.find_by(title: "Welcome").id, primary_image_url: "https://upload.wikimedia.org/wikipedia/commons/5/55/Wikipedia_logo_gold.png"}
]

Revision.create(revisions)

fitness = Category.create(title: "fitness")
animals = Category.create(title: "animals")

Article.find_by(title: "Dogs").categories.push(animals)
Article.find_by(title: "Running").categories.push(fitness)