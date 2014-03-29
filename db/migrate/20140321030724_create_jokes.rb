class CreateJokes < ActiveRecord::Migration
  def self.up
   create_table :jokes do |t|
     t.text :content
     t.string :category
     t.timestamps
   end
 end

 def self.down
   drop_table :jokes
 end
end
