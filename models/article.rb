class Article < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :revisions

  def current_rev
    revisions.last
  end
end