class BookViewModel

  def self.from_read_model(read_model)
    # return BookViewModel based on read model fields
    OpenStruct.new(
      book_title: read_model.title,
      book_author: read_model.author_name,
      reservations: read_model.reservations.map do |reservation|
        OpenStruct.new(user_name: reservation[:user_name])
      end,
      borrow_histories: read_model.borrow_histories.map do |borrow_history|
        OpenStruct.new(user_name: borrow_history[:user_name], borrow_date: borrow_history[:borrowed_at], return_date: borrow_history[:returned_at])
      end
    )
  end

  attr_reader :book_title, :book_author, :reservations, :borrow_histories

  def initialize(book_id)
    @book_id = book_id
  end

  def build
    build_author
    build_title
    build_reservations
    build_borrow_histories
    self
  end

  private

  def book
    @book ||= Book.find(@book_id)
  end

  def build_title
    @book_title ||= book.title
  end

  def build_author
    @book_author ||= book.author.full_name
  end

  def build_reservations
    @reservations ||= Reservation.where(book_id: @book_id)
  end

  def build_borrow_histories
    @borrow_histories ||= BorrowHistory.where(book_id: @book_id).map do |borrow_history|
      OpenStruct.new(user_name: User.find(
        borrow_history.user_id).full_name,
        borrow_date: format_date(borrow_history.borrowed_at), return_date: format_date(borrow_history.returned_at))
    end
  end

  def format_date(date)
    date.strftime("%d-%m-%Y")
  end
end
