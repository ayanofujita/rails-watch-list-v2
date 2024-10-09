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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
