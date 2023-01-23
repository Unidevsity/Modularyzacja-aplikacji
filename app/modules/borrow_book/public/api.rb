module BorrowBook
  module Public
    class Api

      def self.borrow_book(book_id, user)
        # Borrow book logic
        other_params = 'Another param needed to borrow this book'
        BorrowBook::BorrowBook.call(book_id, user, other_param)
      end
    end
  end
end
