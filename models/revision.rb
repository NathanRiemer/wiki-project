class Revision < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_many :comments
end