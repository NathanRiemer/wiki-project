class Article < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :revisions

  def current_rev
    revisions.last
  end

  def last_modified_by
    current_rev.user.username
  end

  def current_content
    current_rev.content
  end
end