class Music < ActiveRecord::Base
	validates_uniqueness_of :url
	self.inheritance_column = nil
end