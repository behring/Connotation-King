class CreateJokes < ActiveRecord::Migration
  def self.up
   create_table :jokes do |t|
   	 t.string :title
     t.text :content
     t.string :url
     t.string :other_urls
     t.timestamps
   end
 end

 def self.down
   drop_table :jokes
 end
end
