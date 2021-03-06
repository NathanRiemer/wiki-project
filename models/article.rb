class Article < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :revisions, dependent: :destroy
  validates :title, uniqueness: true

  def current_rev
    revisions.last
  end

  def last_modified_at
    current_rev.created_at
  end

  def last_modified_by
    current_rev.user.username
  end

  def current_content
    current_rev.content
  end

  def current_image
    current_rev.primary_image_url
  end

  def self.create_from_params (params)
    self.create(title: params[:title])
  end

  def add_category (category_id)
    categories.push(Category.find(category_id))
  end

  def created_by
    revisions.first.user.username
  end

  def created_at
    revisions.first.created_at
  end

  def creation_history
    revisions.first.mod_history("Created")
  end

  def current_history
    current_rev.mod_history("Last modified")
  end

  def path 
    invalid? ? "/articles" : "/articles/#{id}"
  end

  def display_bar (active)
    "<div class='bar'>
      <ul>
        <li #{"class='active'" if active=="read"}><a href=#{path}>Read</a></li>
        <li><a href='#{path+'?print=true'}' target='_blank'>Print</a></li>
        <li #{"class='active'" if active=="edit"}><a href=#{path+'/edit'}>Edit</a></li>
        <li #{"class='active'" if active=="revisions"}><a href=#{path+'/revisions'}>Revisions</a></li>
      </ul>
    </div>"
  end

  def self.where_content_include?(query_string)
    self.all.select {|article| article.current_content.include? query_string}
  end

  def self.where_title_include?(query_string)
    self.all.select {|article| article.title.include? query_string}
  end

  def get_previous_revision(rev) 
    if rev == revisions.first
      rev
    else
      this_index = revisions.index(rev)
      revisions[this_index - 1]
    end
  end


end