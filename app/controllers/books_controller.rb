class BooksController < ApplicationController
  def create
    @shelf = Shelf.find(params[:shelf_id])
    @book = @shelf.books.create(book_params)
    redirect_to shelf_path(@shelf)
  end

  def show


  end

  private
    def book_params
      params.require(:book).permit(:isbn)
    end
end
