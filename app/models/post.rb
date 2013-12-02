class Post < ActiveRecord::Base

  # The has_many method tells Rails that a post object can have many 
  # comments related to it, and also provides methods that enable you 
  # to retrieve comments that belong to a post.
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  # attr_accessible tells the model what attributes should be available
  # to the user
  attr_accessible :body, :title, :topic, :image

  # Display with largest ranking posts first
  default_scope order('rank DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true  

  after_create :create_vote

  mount_uploader :image, ImageUploader

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end 

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  private

  # Who ever created a post, should automatically be set to "voting" it up.
  def create_vote
    self.user.votes.create(value: 1, post: self)
  end 
  
end