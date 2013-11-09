class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :topic, :public
  has_many :posts
end
