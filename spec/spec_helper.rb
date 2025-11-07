ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'database_cleaner/active_record'
require 'factory_bot'
require_relative '../app'
require_relative '../config/database'

Dir[File.join(File.dirname(__FILE__), '../models/*.rb')].sort.each { |file| require file }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  FactoryBot.find_definitions

  def app
    BookReviewAPI
  end

  config.before(:suite) { DatabaseCleaner.strategy = :transaction }
  config.before(:each)  { DatabaseCleaner.start }
  config.after(:each)   { DatabaseCleaner.clean }
end

def json_body
  JSON.parse(last_response.body)
end
