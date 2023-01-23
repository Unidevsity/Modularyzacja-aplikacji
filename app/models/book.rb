class Book < ApplicationRecord
  belongs_to :author

  serialize :reservations, Array
  serialize :borrow_histories, Array
end
