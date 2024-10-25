class FavoritesController < ApplicationController
  before_action :set_list

  def create
    current_user.favorite(@list)
    redirect_to @list, notice: "List saved successfully!"
  end

  def destroy
    current_user.unfavorite(@list)
    redirect_to @list, notice: "List unsaved successfully!"
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end
end
