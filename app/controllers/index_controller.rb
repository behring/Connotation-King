get '/login' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  password = parsedJson["main"]["password"].to_s
  client_user = DBQuery.check_login(email,password)
  if not client_user.nil?
    "#{{:user => client_user}.to_json}"
  else
    "#{{:error => '此帐号尚未注册',
        :error_code=>0,:request=>'/login'}.to_json}"
  end
end


