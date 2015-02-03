class User < ActiveRecord::Base
mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :fici_name, :email, :password, :password_confirmation, :remember_me, 
                  :avatar, :avatar_cache
  # attr_accessible :title, :body

  acts_as_voter

  has_many :microposts, dependent: :destroy

  has_many :friendships, dependent: :destroy

  has_many :comments

  has_many :friends, :through => :friendships,
  					 :conditions => "status = 'accepted'",
  					 :order => :name

  has_many :requested_friends, 
  			:through => :friendships,
  			:source => :friend,
  			:conditions => "status = 'requested'",
  			:order => :created_at

  has_many :pending_friends, 
  			:through => :friendships,
  			:source => :friend,
  			:conditions => "status = 'pending'",
  			:order => :created_at


  validates :name, presence: true, length: {maximum: 50}

  validates :email, presence: true, uniqueness: {case_sensitive: false}

  #validates_presence_of :avatar
  #validates_integrity_of :avatar
  #validates_processing_of :avatar

  def feed
  	Micropost.from_users_friends(self)
  end

  def pending?(friend)
  	pending_friends.include?(friend)
  end

  def requested?(friend)
  	requested_friends.include?(friend)
  end

  def friend?(friend)
  	friends.include?(friend)
  end
end
