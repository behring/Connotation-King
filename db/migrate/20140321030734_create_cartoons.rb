class CreateCartoons < ActiveRecord::Migration
  def self.up
   create_table :cartoons do |t|
     t.string :title
     t.text :description
     t.string :picture_url
     t.string :path
     t.string :category
     t.timestamps
   end
 end

 def self.down
   drop_table :cartoons
 end
end