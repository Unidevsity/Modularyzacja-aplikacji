class RentalsController < ApplicationController

  def borrow_book
    BorrowBook::BorrowBook.call(params[:book_id], current_user)

    @books = Search::ListBorrowedBooks.call(current_user)
  end

end
