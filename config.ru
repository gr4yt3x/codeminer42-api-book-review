require './app'
require './routes/books'
require './routes/users'
require './routes/reviews'

run Rack::URLMap.new(
  '/books'   => BooksRoutes.new,
  '/users'   => UsersRoutes.new,
  '/reviews' => ReviewsRoutes.new
)
