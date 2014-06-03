module DBUpdate
  def self.update_client_user(client_user)
    client_user.save
  end
end