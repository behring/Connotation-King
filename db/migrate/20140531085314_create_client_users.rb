class CreateClientUsers < ActiveRecord::Migration
  def self.up
    create_table :client_users do |t|
      t.string :token
      t.string :nickname
      t.string :email
      t.string :code
      t.string :head_icon_url
      t.string :password
      t.timestamps
    end
  end

  def self.down
    drop_table :client_users
  end
end
