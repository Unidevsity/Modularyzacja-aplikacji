class RentalsController < ApplicationController

  def borrow_book
    # BorrowBook::BorrowBook.call(params[:book_id], current_user)
    BorrowBook::Public::Api.borrow_book(params[:book_id], current_user)

    # @books = Search::ListBorrowedBooks.call(current_user)
    @books = Search::Public::Api.list_borrowed_books(current_user)
  end

end
