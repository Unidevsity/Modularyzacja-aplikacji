class RentalsController < ApplicationController

  def borrow_book
    # BorrowBook::BorrowBook.call(params[:book_id], current_user)
    @book = BorrowBook::Public::Api.borrow_book(params[:book_id], current_user)
    flash[:notice] = "You've just borrowed the book #{@book.title}"

    @book.update(title: 'New title') # NOOOOO!!! You shouldn't be able to to this here!

    # @books = Search::ListBorrowedBooks.call(current_user)
    @books = Search::Public::Api.list_borrowed_books(current_user)
  end

end
