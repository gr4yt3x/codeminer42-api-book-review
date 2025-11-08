require 'sinatra/base'
require 'sinatra/activerecord'
require './models/user'

class UsersRoutes < Sinatra::Base
  get '/' do
    users = User.order(:name)
    users.to_json
  end

  get '/:id' do
    user = User.find_by(id: params[:id])

    if user
      user.to_json
    else
      halt 404, { error: 'User not found' }.to_json
    end
  end

  get '/:id/:reviews' do
    user = User.find_by(id: params[:id])

    if user
      reviews = user.reviews
      reviews.to_json
    else
      halt 404, { error: 'User not found' }.to_json
    end
  end

  post '/' do
    user = User.create(
      name: params[:name]
    )
    name.to_json
  end
end
