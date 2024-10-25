class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(
      name: list_params[:name],
      description: list_params[:description]
      )
    @list.user = current_user

    list_params[:movies].each do |imdb|
      #if the movie doesn't exist in the database
      if Movie.find_by(imdb_id: imdb)
        new_movie = Movie.find_by(imdb_id: imdb)
      else
        url = "http://www.omdbapi.com/?i=#{imdb}&apikey=#{ENV['OMDb_apikey']}"
        movie = JSON.parse(URI.open(url).read)
        if movie["Title"]
          new_movie = Movie.create!(
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
              genre = Genre.find_or_create_by(name: genre)
              new_movie.genres << genre unless new_movie.genres.include?(genre)
            end
          end
        end
      end
      @list.movies << new_movie
    end

    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description, movies: [])
  end
end
