#自动获取验证码接口，客户端轮循调用，直到获取code或者code过期
post '/auto_verify' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s

  puts  "auto_verify interface, select email:#{email}"
  client_user = DBQuery.get_client_user(email)
  puts  "auto_verify interface, select client_user:#{client_user.to_json}"

  if not client_user.code.blank?
    return_code = client_user.code
    client_user.code = ''
    DBUpdate.update_client_user(client_user)

    "#{{:verification_code => return_code}.to_json}"

  else
    "#{{:error => 'have not click email verification url!',
    :error_code=>0,:request=>'/auto_verification'}.to_json}"
  end
end
#邮件连接验证接口
get '/verification' do
  code = params[:code].to_s
  token = params[:token].to_s

  client_user = DBQuery.get_client_user(token)
  client_user.code = code
  DBUpdate.update_client_user(client_user)
  "恭喜您，内含王验证成功！点击返回按钮完成注册。"
end
#注册检测接口，判断邮箱是否注册
post '/check_register' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  client_user = DBQuery.get_client_user(email)
  if not client_user.blank?
    "#{{:status => 1,:user=>client_user}.to_json}"
  else
    "#{{:status => 0}.to_json}"
  end
end

#注册检测接口，判断邮箱是否注册
post '/cancel_register' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  client_user = DBQuery.get_client_user(email)
  if not client_user.blank?
    DBDelete.delete_client_user(email)
  end
  "#{{:status => 1}.to_json}"
end


#获取验证码，验证码将发送到邮箱并返回客户端作为认证
post '/get_verification_code' do
  request_json = params[:param]
  puts "request_json :#{request_json}"
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  puts "email  :#{email}"

  verification_code = rand(999999) #生成6位随机数
  token = SecureRandom.uuid

#message = <<MESSAGE_END
#From:内含王<neihanwang@126.com>
#To:<zhaolin53636848@126.com>
#Subject: 内含王测试邮件
#
#这是一封内含王发给你您的测试邮件.
#MESSAGE_END
#  FROM = 'neihanwang@126.com'
#  FROM_PASSWORD = 'behring0801'
#  FROM_NAME='内含王'
#  TO = email
  #TO_NAME = '亲爱的用户'
  #SUBJECT = '内含王手机客户端验证'

message = <<MESSAGE_END
From:#{FROM_NAME} <#{FROM}>
To:#{TO_NAME} <#{email}>
Content-Type: text/html;charset=utf-8
Charset: UTF-8
MIME-Version: 1.0
Subject: #{SUBJECT}

<table width="700" border="0" cellpadding="10" cellspacing="2">
    <tbody>
    <tr>
        <td height="136" align="center" valign="middle" bgcolor="#FFFFFF">
            <table width="94%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td align="left" valign="top" class="lh15">
                      <font>尊敬的#{FROM_NAME}用户 ：<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        您好！<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        您在#{FROM_NAME}进行帐号验证操作的验证码为: #{verification_code}。<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        请您将此验证码输入到<font color="#0066cc">"内含王手机客户端"</font>的验证码框内，继续完成操作。<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        您也可以点击如下链接来完成帐号自动认证验证。<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="#{URL_VERIFICATION}?token=#{token}&code=#{verification_code}">
                        点击这里...
                        </a><br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        验证将会在5分钟后失效，请尽快完成身份验证，否则需要重新进行验证。<br><br>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        如果有其他问题，请联系我们：#{FROM} 谢谢！<br><br>
                        此为系统消息，请勿回复<br>
                      </font>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>
MESSAGE_END


  begin
    Net::SMTP.start('smtp.126.com', 25, 'mail.126.com',
                    FROM, FROM_PASSWORD, :plain) do |smtp|
      smtp.send_message message, FROM,email

      client_user = ClientUser.new
      client_user.token = token
      client_user.email = email
      DBAdd.add_client_user(client_user)

      "#{{:verification_code => verification_code}.to_json}"

    end
  rescue  #$! :表示异常信息 $@ :表示异常出现的代码位置
    puts "error:#{$!} at:#{$@}"
    "#{{:error => 'server send email an error!',
        :error_code=>0,:request=>'/get_verification_code'}.to_json}"
  end


end


#最终注册接口，获得用户信息后，返回token
post '/register' do
  request_json = params[:param]
  puts "request_json :#{request_json}"
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  nickname = parsedJson["main"]["nickname"].to_s
  puts "email:#{email}   nickname:#{nickname}"

  filename = params[:head_icon][:filename]
  tempfile = params[:head_icon][:tempfile]

  client_user = DBQuery.get_client_user(email)
  token = client_user.token
  #file_name = "user/avatar/#{filename}"
  file_name = "user/avatar#{token}.jpg"

  dir_upload = File.dirname(file_name)
  unless File.directory?(dir_upload)
    FileUtils.mkdir_p(dir_upload)
  end
  File.open(file_name, 'wb') {|f| f.write tempfile.read }

# Get an instance of the S3 interface.
  s3 = AWS::S3.new
# Upload a file.
  s3.buckets[BUCKET_NAME].objects[file_name].write(:file => file_name)
  puts "Uploading file #{file_name} to bucket #{BUCKET_NAME}."

  head_icon_url = s3.buckets[BUCKET_NAME].objects[file_name].public_url.to_s
  puts "upload file url #{head_icon_url}"

  client_user.head_icon_url = head_icon_url
  client_user.nickname = nickname
  DBUpdate.update_client_user(client_user)


  "#{{:user => client_user}.to_json}"

end


