post '/login' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  password = parsedJson["main"]["password"].to_s
  client_user = DBQuery.check_login(email,password)
  if not client_user.nil?
    "#{{:user => client_user}.to_json}"
  else
    "#{{:error => '此帐号尚未注册,或密码错误',
        :error_code=>0,:request=>'/login'}.to_json}"
  end
end


post '/set_password' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  token = parsedJson["main"]["token"].to_s
  password = parsedJson["main"]["password"].to_s

  client_user = DBQuery.get_client_user(token)
  puts "client_user : #{client_user}"
  if not client_user.nil?
    client_user.password = password
    DBUpdate.update_client_user(client_user)
    "#{{:status => 1}.to_json}"
  else
    "#{{:error => '无法设置密码，用户不存在',
        :error_code=>0,:request=>'/login'}.to_json}"
  end
end


