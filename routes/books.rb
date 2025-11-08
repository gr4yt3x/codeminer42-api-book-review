require 'sinatra/base'
require 'sinatra/activerecord'
require './models/book'

class BooksRoutes < Sinatra::Base
  get '/' do
    books = Book.all
    books.to_json
  end

  get '/:id' do
    book = Book.find_by(id: params[:id])

    if book
      book.to_json
    else
      halt 404, { error: 'Book not found' }.to_json  
    end
  end

  post '/' do
    book = Book.create(
      title: params[:title],
      author: params[:author],
      published_year: params[:published_year]
    )
    book.to_json
  end
end
