ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: File.join(__dir__, '..', 'db', 'app.db')
)
