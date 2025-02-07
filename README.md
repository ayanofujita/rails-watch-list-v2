# 📚 Movie Watchlist v2

A web application that allows users to create, manage, and share personalized movie lists. Users can also save and leave reviews for others' lists. The app is fully responsive, offering a smooth experience across all devices.

![alt text](https://github.com/ayanofujita/rails-watch-list-v2/blob/master/app/assets/images/movielist2_ss.png?raw=true)

App home: https://watch-list-v2-08a859a1db81.herokuapp.com/
<br>
v1: https://old-aya-watchlist-20fde36147bd.herokuapp.com/
<br>
v1 repo: https://github.com/ayanofujita/rails-watch-list
## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
<br>
Inside `.env`, set these variables.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
OMDb_apikey=your_own_omdb_api_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Acknowledgements
[Figma Design](https://www.figma.com/community/file/1121715218417063090/movie-watchlist-project) by [Michael Epelboim](https://www.figma.com/@sdrmike)
