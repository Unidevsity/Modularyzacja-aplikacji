author = Author.create(
  first_name: 'John R. R.',
  last_name: 'Tolkien',
)

book = Book.create(
  title: 'The Hobbit',
  author: author,
)

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
  borrowed_at =  rand(1..100).days.ago
  returned_at = borrowed_at + 7.days
  BorrowHistory.create(
    user: user,
    book: book,
    borrowed_at: borrowed_at,
    returned_at: returned_at,
  )
end
