class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :show, presence: true, length: {maximum: 100}

  validates :food, presence: true, length: {maximum: 30}
end
