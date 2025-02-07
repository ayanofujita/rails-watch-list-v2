# 📚 Movie Watchlist version 2

A web application that allows users to create, manage, and share personalized movie lists. It builds upon the original version, which was created as part of my Le Wagon bootcamp. Version 2 introduces several key features that were not present in Version 1:

- **User sign-in**: Each user can create an account and log in to access their personal watchlists and reviews.
- **Wider movie collection**: Integration with the OMDB API allows users to search for movies from a much larger selection.
- **Sorting by popularity**: Users can sort their movie lists based on movie popularity.
- **Saving other users' watchlists**: Users can now save other people's movie lists to their own account.
- **Responsiveness**: The app is fully responsive, ensuring a smooth and consistent experience across multiple devices.


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
