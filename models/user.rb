require_relative '../config/database'
require 'active_record'

class User < ActiveRecord::Base
  has_many :reviews
  has_many :books, through: :reviews
end
