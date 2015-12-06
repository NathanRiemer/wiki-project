require_relative "config"
require "ffaker"

users = []

10.times do 
  users.push({username: FFaker::Internet.user_name, password: "password", email: FFaker::Internet.email, is_admin: FFaker::Boolean.maybe, city: FFaker::AddressUS.city, state: FFaker::AddressUS.state_abbr, country: FFaker::AddressUS.country}, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
end

User.create(users)

articles = []

10.times do
  articles.push(title: FFaker::HipsterIpsum.word)
end

Article.create(articles)

revisions = []

articles.each do |article_hash|
  3.times do 
    revisions.push({content: FFaker::HipsterIpsum.paragraphs, created_at: DateTime.now, user_id: User.all.sample.id, article_id: Article.find_by(title: article_hash[:title]).id})
  end
end

Revision.create(revisions)

comments = []

20.times do 
  comments.push({content: FFaker::HipsterIpsum.paragraph, created_at: DateTime.now, user_id: User.all.sample.id, revision_id: Revision.all.sample.id})
end

Comment.create(comments)

categories = []
10.times do 
  categories.push({title: FFaker::Lorem.word})
end

Category.create(categories)

20.times do 
  article = Article.all.sample
  article.categories.push(Category.all.sample)
end