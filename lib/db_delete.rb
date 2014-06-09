module DBDelete
  def self.delete_client_user(email)
    ClientUser.destroy_all(:email => email)
  end
end