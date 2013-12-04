FactoryGirl.define do
  factory :comment do
    body "This is a new comment"
    user
    post
  end
end