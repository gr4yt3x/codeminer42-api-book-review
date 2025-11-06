require_relative '../config/database'
require 'active_record'

class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews 
end
