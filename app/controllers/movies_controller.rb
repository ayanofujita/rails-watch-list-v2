require 'open-uri'
require 'json'

class MoviesController < ApplicationController
  def fetch_movie
    encoded_title = URI.encode_www_form_component(params[:movie_title])
    url = "http://www.omdbapi.com/?s=#{encoded_title}&apikey=#{ENV['OMDb_apikey']}"
    response = JSON.parse(URI.open(url).read)

    respond_to do |format|
      format.json { render json: response }
    end
  end

  def fetch_movie_info
    @movie = Movie.find_by(imdb_id: params[:movie_id])
    respond_to do |format|
      format.text { render partial: "shared/movie_info", locals: { movie: @movie }, formats: [:html]}
    end
  end

  def index
  end
end
