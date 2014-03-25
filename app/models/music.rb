class Music < ActiveRecord::Base
	validates_uniqueness_of :url
	# self.inheritance_column = nil#解决字段和系统字段冲突的问题如type
end