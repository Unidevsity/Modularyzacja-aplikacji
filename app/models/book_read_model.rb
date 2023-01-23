class BookReadModel < ApplicationRecord
  belongs_to :book
  serialize :reservations, Array
  serialize :borrow_histories, Array
end
