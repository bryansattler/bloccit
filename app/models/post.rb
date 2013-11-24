class Post < ActiveRecord::Base

  #The has_many method tells Rails that a post object can have many 
  #comments related to it, and also provides methods that enable you 
  #to retrieve comments that belong to a post.
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  #attr_accessible tells the model what attributes should be available
  #to the user
  attr_accessible :body, :title, :topic, :image

  mount_uploader :image, ImageUploader  

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true    
end