class User < ActiveRecord::Base
  has_many :comments
  has_many :revisions
  has_many :articles, through: :revisions
end