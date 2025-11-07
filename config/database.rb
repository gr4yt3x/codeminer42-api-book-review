require 'active_record'

env = ENV['RACK_ENV'] || 'development'

db_config = {
  'development' => {
    adapter: 'sqlite3',
    database: File.join(__dir__, '..', 'db', 'app.db')
  },
  'test' => {
    adapter: 'sqlite3',
    database: File.join(__dir__, '..', 'db', 'test.db')
  }
}

ActiveRecord::Base.establish_connection(db_config[env])
