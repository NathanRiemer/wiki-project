require "bcrypt"

class User < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :revisions
  has_many :articles, through: :revisions

  def num_articles
    articles.uniq.count
  end

  def num_revisions
    revisions.count
  end

  def num_comments
    comments.count
  end

end