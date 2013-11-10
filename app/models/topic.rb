class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :topic, :public, :image
  has_many :posts

  mount_uploader :image, ImageUploader
end
