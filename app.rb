require 'sinatra/base'

class BookReviewAPI < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
