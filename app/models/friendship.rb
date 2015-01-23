class Friendship < ActiveRecord::Base
  

  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"

  attr_accessible :approved, :friend_id, :user_id, :status, :user, :friend

  validates :user_id, presence: true
  validates :friend_id, presence: true

  # Return true if the users are(possibly pending) friends
  def self.exist?(user, friend)
  	not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # Record a pending friend request
  def self.request(user, friend)
  	unless user == friend or Friendship.exist?(user, friend)
  		transaction do 
  			Friendship.create(user: user, friend: friend, status: 'pending')
  			Friendship.create(user: friend, friend: user, status: 'requested')
  		end
  	end
  end

  # Accept a friend request
  def self.accept(user, friend)
  	transaction do
  		accepted_at = Time.now
  		accept_one_side(user, friend, accepted_at)
  		accept_one_side(friend, user, accepted_at)
  	end
  end

  # Delete a friendship or cancel a panding request
  def self.breakup(user, friend)
  	transaction do
  		Friendship.destroy(find_by_user_id_and_friend_id(user, friend))
  		Friendship.destroy(find_by_user_id_and_friend_id(friend, user))
  	end
  end

  private

  	# Update the db with one side of an accepted friendship request
  	def self.accept_one_side(user, friend, accepted_at)
  		request = find_by_user_id_and_friend_id(user, friend)
  		request.status = 'accepted'
  		request.accepted_at = accepted_at
  		request.save!
  	end
 end
