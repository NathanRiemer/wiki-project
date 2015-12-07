class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates :title, uniqueness: true

  def path
    invalid? ? "/categories" : "/categories/#{id}"
  end

  def self.popular
    self.all.select { |category| category.articles.length > 2 }
  end

  def self.where_title_include?(query_string)
    self.all.select { |category| category.title.include? query_string }
  end
end