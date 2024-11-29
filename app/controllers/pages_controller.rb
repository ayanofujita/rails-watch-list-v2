class PagesController < ApplicationController
  def home
    @popular_movies = Movie.order(:rating ).limit(10).reverse_order
    @popular_lists = List.all #TODO !!
  end
end
