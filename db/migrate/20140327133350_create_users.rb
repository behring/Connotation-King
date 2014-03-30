class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identity_user
      t.string :nickname
      t.string :input_content
      t.integer :data_type
      t.integer :data_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
