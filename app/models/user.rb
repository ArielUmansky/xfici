# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#  fici_name              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :fici_name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :microposts, dependent: :destroy

  has_many :friendships, dependent: :destroy

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
