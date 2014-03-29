class Joke < ActiveRecord::Base
	validates_uniqueness_of :content
end