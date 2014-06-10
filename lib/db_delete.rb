module DBDelete
  def self.delete_client_user(email)
    ClientUser.destroy_all(:email => email)
  end


  def self.delete_all_book()
    Book.delete_all()
  end
end