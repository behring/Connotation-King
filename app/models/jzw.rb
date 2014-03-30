class Jzw < ActiveRecord::Base
	validates_uniqueness_of :question
end