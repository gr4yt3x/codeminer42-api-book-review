require_relative '../config/database'
require 'active_record'

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
end
