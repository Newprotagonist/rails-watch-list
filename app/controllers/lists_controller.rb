class ListsController < ApplicationController
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @bookmarks = @list.bookmarks
  end

  def create
    @lists = List.all
    @list = List.new(list_params)
    @list.save
    if @list.save
      redirect_to list_path(@list.id)
    else
      render 'index', status: :unprocessable_entity, message: 'Missing something to create a list'
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to :lists, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
