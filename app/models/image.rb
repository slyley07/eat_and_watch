class Image < ActiveRecord::Base
  belongs_to :User
  mount_uploader :image, ImageUploader
end
