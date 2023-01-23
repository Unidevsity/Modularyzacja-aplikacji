class BooksController < ApplicationController

  def index
    @books = Book.all
  end
  def show
    @book = Book.find(params[:id])
    @reservations = Reservation.where(book_id: @book.id)
    @borrow_histories = BorrowHistory.where(book_id: @book.id)
  end
end
