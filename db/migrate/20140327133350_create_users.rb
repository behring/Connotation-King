class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identity_user
      t.string :identity_cartoon
      t.string :identity_joke
      t.string :identity_jzw
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
