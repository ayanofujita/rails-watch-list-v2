require 'nokogiri'
require 'uri'
require 'json'
require 'date'

List.delete_all
User.delete_all
Movie.delete_all
Genre.delete_all

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

puts "creating 4 lists with movies"

lists = [
  {
    name: "Things That Piqued My Interest & Tickled My Fancy",
    description: "When I get around to watching something listed here, I'll remove it from the list (that's the plan, anyway!), so be sure to add any that interest you to your own Watchlist. If you get anything out of this, or just want to keep an eye on it for possible viewing ideas in the future, please hit 'Like'.",
    user: User.find_by(username: "HabiPieKing"),
    url: "https://letterboxd.com/brokenclaw/list/things-that-piqued-my-interest-tickled-my/"
  },
  {
    name: "classic movies for beginners.",
    description: "꒰ old hollywood & classic films (1920s — 1960s) for you who want to start watching ౨ৎ — only my personal recommendations ♡",
    user: User.find_by(username: "brianUchiha"),
    url: "https://letterboxd.com/hepburnluv/list/classic-movies-for-beginners/"
  },
  {
    name: "🐉🎭✨ 𝕍𝕀𝕊𝕌𝔸𝕃𝕃𝕐 𝙸𝙽𝚂𝙰𝙽𝙴👹🧞‍♀️👁️",
    description: "Am I missing your favorite hallucinogenic, meditative, harrowing, dreamy, or chaotic visual feast? Comment here (with year and/or director please!) and I'll include your recs in the list.\nNote: I have not updated the above list in a while, it's from when this was WAY smaller. At some point I'll go through the most common suggestions again and edit to reflect them.",
    user: User.find_by(username: "AyyyaSayonara"),
    url: "https://letterboxd.com/etolkin/list/filmlist:28697007/"
  },
  {
    name: "Weirdo Watchlist",
    description: "Movies that are slightly off.",
    user: User.find_by(username: "SuperSaiyanIkumi"),
    url: "https://letterboxd.com/hamburgersplash/list/weirdo-watchlist/"
  },
]

lists.each_with_index do |list, index|
  List.create!(
    name: list[:name],
    description: list[:description],
    user: list[:user]
  )

  puts "#{index}th list created!"
  puts "creating movies"

  url = list[:url]
  html_file = URI.parse(url).read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(".poster-list li img").first(20).each do |element|
    movie_title = element.attribute("alt").value
    encoded_title = URI.encode_www_form_component(movie_title)
    url = "http://www.omdbapi.com/?t=#{encoded_title}&apikey=#{ENV['OMDb_apikey']}"

    begin
      Timeout.timeout(5) do
        movie = JSON.parse(URI.open(url).read)
        if movie["Title"]
          unless Movie.find_by(title: movie["Title"])
            Movie.create!(
              title: movie["Title"],
              overview: movie["Plot"] || "No overview available",
              poster_url: movie["Poster"] || "https://via.placeholder.com/300x450?text=No+Image+Available",
              rating: movie["imdbRating"] || 0,
              year: movie["Year"].to_i,
              rated: movie["Rated"] || "Not Rated",
              released: movie["Released"] ? Date.parse(movie["Released"]) : nil,
              runtime: movie["Runtime"] ? movie["Runtime"].split.first.to_i : 0,
              imdb_id: movie["imdbID"]
            )
            if movie["Genre"]
              movie["Genre"].split(", ").each do |genre|
                Genre.create!(name: genre) unless Genre.find_by(name: genre)
                Movie.last.genres << Genre.find_by(name: genre)
              end
            end
          end
          List.last.movies << Movie.find_by(title: movie["Title"])
        end
      end
    rescue Timeout::Error
      puts "The request for #{movie_title} timed out."
    rescue StandardError => e
      puts "Error occured: #{e.message}"
    end
  end

  puts "created #{List.last.movies.count} movies! for #{List.last.name}"
end
