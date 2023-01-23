class BooksController < ApplicationController

  def index
    @books = Book.all
  end
  def show
    @book_view_model = ::BookViewModel.new(params[:id]).build
  end
end
