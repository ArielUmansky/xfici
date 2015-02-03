class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id, :user_id, :user

  belongs_to :micropost
  belongs_to :user 

  validates :user_id, presence: true
  validates :micropost_id, presence: true
  
end
