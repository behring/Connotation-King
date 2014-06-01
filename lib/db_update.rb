module DBUpdate
  def self.update_client_user(client_user)
    client_user.save
    #ClientUser.update(client_user.id,token: client_user.token, nickname: client_user.nickname, email: client_user.email,code: client_user.code)
  end
end