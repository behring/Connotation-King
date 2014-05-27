class Book < ActiveRecord::Base
  validates_uniqueness_of :book_url
end
