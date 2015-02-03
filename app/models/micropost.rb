class Micropost < ActiveRecord::Base
  attr_accessible :content

  acts_as_votable

  belongs_to :user

  has_many :comments, dependent: :destroy

  default_scope order: 'microposts.created_at DESC'

  validates :user_id, presence: true

  validates :content, presence: true, length: { maximum: 140 }

  # Returns microposts from the friends of the user
  def self.from_users_friends(user)
  	friends_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id and status='accepted'"
  	where("user_id IN (#{friends_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
