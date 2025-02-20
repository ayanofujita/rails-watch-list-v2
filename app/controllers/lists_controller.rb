class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all

    if params[:sort] == 'name'
      @lists = @lists.order(name: :asc)
    elsif params[:sort] == 'likes'
      @lists = List.joins("LEFT JOIN favorites ON favorites.favoritable_id = lists.id")
      .group(:id)
      .select('lists.*, COUNT(favorites.id) AS likes_count')
      .order('likes_count DESC')
    end
  end

  def show
    @movies = List.find(params[:id]).movies
    if params[:sort] == 'title'
      @movies = @movies.order(title: :asc)
    elsif params[:sort] == 'rating'
      @movies = @movies.order(rating: :desc)
    end
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

    if list_params[:movies]
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
              poster_url: movie["Poster"].gsub("SX300", "SX500") || "https://via.placeholder.com/300x450?text=No+Image+Available",
              rating: movie["imdbRating"],
              year: movie["Year"].to_i || nil,
              rated: movie["Rated"] || "Not Rated",
              released: movie["Released"] ? Date.parse(movie["Released"]) : nil,
              runtime: movie["Runtime"] ? movie["Runtime"].split.first.to_i : nil,
              imdb_id: movie["imdbID"],
              director: movie["Director"]
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
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  def movie_destroy
    list = List.find(params[:list_id])
    movie = Movie.find(params[:id])
    list.movies.delete(movie)
    redirect_to edit_list_path(list)
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description, movies: [])
  end
end
