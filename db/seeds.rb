require 'faker'

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save

  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  rand(5..12).times do
    p = u.posts.create(
      title: Faker::Lorem.words(rand(1..10)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    # set the created_at to a time within the past year
    p.update_attribute(:created_at, Time.now - rand(600..31536000))

    rand(3..7).times do
      p.comments.create(
        body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"))
    end
  end
end

u = User.first
u.skip_reconfirmation!
u.update_attributes(email: 'bsattler@gmail.com', password: 'helloworld', password_confirmation: 'helloworld')

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"