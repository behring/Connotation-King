class Jzw < ActiveRecord::Base
	validates_uniqueness_of :page_row_number#format:pagenum.rownum
end