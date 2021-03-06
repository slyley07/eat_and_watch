class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one :avatar, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :followed, through: :passive_relationships, source: :follower

  validates_uniqueness_of :username, :email, case_sensitive: :false

  validates_presence_of :username, :email, :password

  validates :username, format: {with: /\A\w+\z/, message: "Only letters, numbers, and underscores allowed"}

  def self.find_by_email(email)
    User.where("lower(email) = ?", email.downcase).first
  end

  def self.find_by_username(username)
    User.where('lower(username) = ?', username.downcase).first
  end
end
