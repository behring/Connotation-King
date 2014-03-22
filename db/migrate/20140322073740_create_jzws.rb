class CreateJzws < ActiveRecord::Migration
  def self.up
   create_table :jzws do |t|
   	 t.string :page_row_number
   	 t.string :qustion
     t.text :answer
     t.timestamps
   end
 end

 def self.down
   drop_table :jzws
 end
end
