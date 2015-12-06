class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates :title, uniqueness: true

  def path
    "/categories/#{id}"
  end

  def self.popular
    self.all.select {|category| category.articles.length > 2}
  end
end