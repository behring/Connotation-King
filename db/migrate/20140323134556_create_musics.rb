class CreateMusics < ActiveRecord::Migration
  def self.up
   create_table :musics do |t|
   	 t.string :singer
   	 t.string :song
     t.string :url
     t.string :durl
     t.string :type
     t.timestamps
   end
 end

 def self.down
   drop_table :musics
 end
end
