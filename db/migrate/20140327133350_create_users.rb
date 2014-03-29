class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identity_user
      t.string :nickname
      t.string :input_content
      t.string :data_type
      t.string :data_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
