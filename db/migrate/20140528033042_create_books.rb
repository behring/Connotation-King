class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.integer :volume_number
      t.string :cover_url
      t.string :book_url
      t.string :book_size
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end