class Revision < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_many :comments, dependent: :destroy

  def mod_history (word)
    "#{word} by <a href='/users/#{user.id}'>#{user.username}</a> on #{created_at.strftime("%A, %B %d, %Y at %l:%M %p")}"
  end

  def mod_history_with_date_link (word)
    "#{word} by <a href='/users/#{user.id}'>#{user.username}</a> on <a href='/articles/#{article.id}/revisions/#{id}'>#{created_at.strftime("%A, %B %d, %Y at %l:%M %p")}</a>"
  end

end