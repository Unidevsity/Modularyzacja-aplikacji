class BooksController < ApplicationController

  after_action :rebuild_read_model, only: [:borrow, :return, :create]

  def index
    # Rails.cache.fetch("all_books", expires_in: 2.hours) do
    #   @books = Book.all
    # end
  end

  def show
    # @book_view_model = ::BookViewModel.new(params[:id]).build
    book_read_model = BookReadModel.find_by(book_id: params[:id])
    @book_view_model = BookViewModel.from_read_model(book_read_model)

    # render json: book_read_model
  end

  def create

  end

  def borrow

  end

  def return

  end

  private

  def rebuild_read_model
    read_model = BookReadModel.find_or_initialize_by(book_id: params[:id])
    read_model.reservations = Reservation.where(book_id: params[:id]).map do |reservation|
      {
        user_id: reservation.user_id,
        user_name: User.find(reservation.user_id).full_name,
      }
    end

    read_model.borrow_histories = BorrowHistory.where(book_id: params[:id]).map do |borrow_history|
      {
        user_id: borrow_history.user_id,
        user_name: User.find(borrow_history.user_id).full_name,
        borrowed_at: borrow_history.borrowed_at.to_s,
        returned_at: borrow_history.returned_at.to_s
      }
    end

    read_model.save
  end
end
