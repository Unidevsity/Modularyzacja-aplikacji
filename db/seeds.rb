author = Author.create(
  first_name: 'John R. R.',
  last_name: 'Tolkien',
)

# list of book titles written by tolkien
titles = [
  'The Hobbit',
  'The Fellowship of the Ring',
  'The Two Towers',
  'The Return of the King',
]


books = titles.map do |title|
  Book.create!(
    title: title,
    author: author,
  )
end

book = books.first

users = 10.times.map do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
  )
end

users.each do |user|
  Reservation.create(
    user: user,
    book: book,
  )
end

users.each do |user|
  borrowed_at = rand(1..100).days.ago
  returned_at = borrowed_at + 7.days
  BorrowHistory.create(
    user: user,
    book: book,
    borrowed_at: borrowed_at,
    returned_at: returned_at,
  )
end

def rebuild_read_model(book_id)
  read_model = BookReadModel.find_or_initialize_by(book_id: book_id)
  read_model.reservations = Reservation.where(book_id: book_id).map do |reservation|
    {
      user_id: reservation.user_id,
      user_name: User.find(reservation.user_id).full_name,
    }
  end

  read_model.borrow_histories = BorrowHistory.where(book_id: book_id).map do |borrow_history|
    {
      user_id: borrow_history.user_id,
      user_name: User.find(borrow_history.user_id).full_name,
      borrowed_at: borrow_history.borrowed_at.to_s,
      returned_at: borrow_history.returned_at.to_s
    }
  end

  read_model.save
end

books.each do |b|
  rebuild_read_model(b.id)
end


