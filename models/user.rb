require "bcrypt"

class User < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :revisions
  has_many :articles, through: :revisions
  validates :username, uniqueness: true
  validates :email, uniqueness: true

  def num_articles
    articles.uniq.count
  end

  def num_revisions
    revisions.count
  end

  def num_comments
    comments.count
  end

  def admin?
    is_admin
  end

  def path
    invalid? ? "/users" : "/users/#{id}"
  end

end