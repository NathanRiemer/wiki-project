class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :revision

  def history
    "<a href='/users/#{user.id}'>#{user.username}</a> on #{created_at.strftime("%A, %B %d, %Y at %l:%M %p")} commented:"
  end
end