class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates :title, uniqueness: true
end