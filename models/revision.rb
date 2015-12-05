class Revision < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_many :comments

  def mod_history (word)
    "#{word} by #{user.username} on #{created_at.strftime("%A, %B %d, %Y at %l:%M %p")}"
  end


end