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

  get '/:id/reviews' do
    book = Book.find_by(id: params[:id])

    if book
      reviews = book.reviews
      reviews.to_json
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

    if book.save
      status 201
      book.to_json
    else
      halt 422, { error: book.errors.full_messages }.to_json
    end
  end

  put '/:id' do
    book = Book.find_by(id: params[:id])

    if book.nil?
      halt 404, { error: 'Book not found' }.to_json
    elsif book.update(
      title: params[:title],
      author: params[:author],
      published_year: params[:published_year]
    )
      status(200)
      book.to_json
    else
      halt 422, { error: book.errors.full_messages }.to_json
    end
  end

  delete '/:id' do
    book = Book.find_by(id: params[:id])

    if book
      book.destroy
      status(204)
    else
      halt 404, { error: 'Book not found' }.to_json
    end
  end 
end
