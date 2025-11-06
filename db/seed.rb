require_relative '../models/user'
require_relative '../models/book'
require_relative '../models/review'

Review.delete_all
Book.delete_all
User.delete_all

users = %w[Alice Bob Charlie Diana Eve Frank Grace Heidi Ivan Judy].map do |name|
  User.create!(name: name)
end

books = [
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", published_year: 1925 },
  { title: "To Kill a Mockingbird", author: "Harper Lee", published_year: 1960 },
  { title: "1984", author: "George Orwell", published_year: 1949 },
  { title: "Pride and Prejudice", author: "Jane Austen", published_year: 1813 },
  { title: "The Catcher in the Rye", author: "J.D. Salinger", published_year: 1951 },
  { title: "The Hobbit", author: "J.R.R. Tolkien", published_year: 1937 }
].map { |b| Book.create!(b) }

reviews = [
  [0, 0, 5, "A masterpiece of American literature."],
  [1, 0, 4, "Great read, but a bit overrated."],
  [2, 1, 5, "A touching story about justice and morality."],
  [3, 1, 4, nil],
  [4, 2, 5, "A chilling dystopian novel that feels relevant today."],
  [5, 2, 3, "Good, but not my favorite Orwell book."],
  [6, 3, 5, "A timeless romance with sharp social commentary."],
  [7, 3, 4, nil],
  [8, 4, 4, "A classic coming-of-age story."],
  [9, 4, 3, nil],
  [0, 5, 5, "An epic fantasy adventure that captivates readers of all ages."],
  [1, 5, 4, nil]
]

reviews.each do |u, b, r, c|
  Review.create!(user_id: users[u].id, book_id: books[b].id, rating: r, comment: c)
end

puts "Database seeded!"
