require 'sinatra/base'
require 'sinatra/activerecord'
require './models/review'

class ReviewsRoutes < Sinatra::Base
  get '/' do
    reviews = Review.all
    reviews.to_json
  end
end
