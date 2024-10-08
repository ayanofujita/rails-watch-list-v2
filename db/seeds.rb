# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create users
User.delete_all

puts "creating 4 main users..."
users = [
  { email: "brianisloco@hotmail.com", password: "123456", username: "brianUchiha", image: "https://res.cloudinary.com/dzfjdlafz/image/upload/v1723600697/brian_zwyeui.jpg" },
  { email: "Aya0123@gmail.com", password: "secret", username: "AyyyaSayonara", image: "https://res.cloudinary.com/dzfjdlafz/image/upload/v1723600697/aya_sqzo1w.jpg" },
  { email: "Javierisdaman@gmail.com", password: "pieking101", username: "HabiPieKing", image: "https://res.cloudinary.com/dzfjdlafz/image/upload/v1723600697/javi_pps9n6.jpg" },
  { email: "IkumiOjiro2017@gmail.com", password: "mybirthday01", username: "SuperSaiyanIkumi", image: "https://res.cloudinary.com/dzfjdlafz/image/upload/v1723600699/ikumi_lqqsra.png" }
]
users.each_with_index do |user, index|
  User.create!(
    email: user[:email],
    password: user[:password],
    username: user[:username]
  )
  User.last.photo.attach(io: URI.open(user[:image]), filename: "user#{ index }.jpg")
end
puts "4 main users created!"

puts "creating movies"
puts

puts "creating 4 watchlists"
w_lists = [
  {
    name
  }
]
