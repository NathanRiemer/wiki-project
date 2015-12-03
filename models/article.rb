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

  def self.create_from_params (params)
    self.create(title: params[:title])
  end

  def add_category (category_id)
    categories.push(Category.find(category_id))
  end

  def created_by
    revisions.first.user
  end

  def created_at
    revisions.first.created_at
  end

end