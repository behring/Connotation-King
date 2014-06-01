
get '/test' do
	# page = Nokogiri::HTML(open(URI.encode("http://www.2345.com/jzw/1.htm")))
	# # node_jzw_count = page.css('div.jzw_container ul li').size
	# # "#{node_jzw_count}"


	# node_jzw = page.css('div.jzw_container ul li')[49];
	# #抓取急转弯问题
	# node_qustion = node_jzw.css('span')[0].text.to_s
	# qustion = node_qustion.encode("UTF-8")
	

	# #抓取急转弯答案
	# node_answer = node_jzw.css('span')[1].to_s
	# node_answer = node_answer.encode("UTF-8")
	# parser = Nokogiri.parse(node_answer)
	# answer = parser.xpath('//a[@onclick]').first.attributes['onclick'].content.match(/'([^']+)/)[1]
	

	# "#{qustion}  :#{answer}"
	# song = "冰雨"
	# singer = "刘德华"
	# url = "http://box.zhangmen.baidu.com/x?op=12&count=1&title=#{song}$$#{singer}$$$$"
	# page = Nokogiri::XML(open(URI.encode(url)))
	# node_encode_text = page.xpath('/result/url/encode').text
	# node_decode_text = page.xpath('/result/url/decode').text
	# reg_str = /http:\/\/([\w+\.]+)(\/(\w+\/)+)/
	# encode_result = reg_str.match(node_encode_text)
	# decode_result = node_decode_text.split('&')[0]

	# count = page.xpath("/result/p2p/type").text
	# "#{count.class}"

  music = BaiduMusic.get_music('刘德华','冰雨')
"music URL：#{music.url}"
  # song = "冰雨"
  # singer = "刘德华"
  # music = BaiduMusic.get_music(singer,song)
  # "#{music.url}\n\n\n\n\n#{music.durl}"

end


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

get '/verification' do
  code = params[:code].to_s
  token = params[:token].to_s

  client_user = DBQuery.get_client_user(token)
  client_user.code = code
  DBUpdate.update_client_user(client_user)
  "恭喜您，内含王验证成功！点击返回按钮完成注册。"
end


post '/check_register' do
  request_json = params[:param]
  parsedJson = JSON.parse(request_json)
  email = parsedJson["main"]["email"].to_s
  client_user = DBQuery.get_client_user(email)
  if not client_user.blank?
    "#{{:status => 1}.to_json}"
  else
    "#{{:status => 0}.to_json}"
  end
end

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
    end
  rescue  #$! :表示异常信息 $@ :表示异常出现的代码位置
    puts "error:#{$!} at:#{$@}"

  end




  client_user = ClientUser.new
  client_user.token = token
  client_user.email = email
  DBAdd.add_client_user(client_user)

  "#{{:verification_code => verification_code}.to_json}"
end


get '/bucket/update' do

	s3 = AWS::S3.new
	puts "get an instance of the S3 interface."
	puts "remove bucket #{BUCKET_NAME} if exist"
	bucket = s3.buckets[BUCKET_NAME]

	# bucket.objects.each do |obj|
 #  		puts obj.key
	# end
  cartoon_books = bucket.objects.with_prefix(BUCKET_DATA_CARTOON)
  cartoon_covers = bucket.objects.with_prefix(BUCKET_IMAGES_CARTOON_COVER).collect(&:public_url)
  puts "cartoon_books count:#{cartoon_books.count}   cartoon_books count:#{cartoon_covers.count}"
  cartoon_books.each_with_index do |s3_book,index|
    if index>0
      book = Book.new
      book.volume_number = index
      book.book_url= s3_book.public_url.to_s
      book.cover_url = cartoon_covers[index].to_s
      book.book_size = s3_book.content_length.to_s
      DBAdd.add_book(book)
      puts "bookUrl:#{book.book_url}   bookSize:#{book.book_size}  bookCover:#{book.cover_url}"


    end

  end

	#case request_path
	#	when BUCKET_DATA_CARTOON  #each_with_index(:limit => 5)
	#		bucket.objects.with_prefix("#{request_path}").each_with_index do |cover,index|
  	#		if index>0
  	#			puts "#{cover.public_url}   #{index}"
   #     end
   #   end
   # when BUCKET_IMAGES_CARTOON_COVER
	#end

	"update ok"
end


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
  #target = "upload/#{filename}"
  target = "upload/#{token}.jpg"

  dir_upload = File.dirname(target)
  unless File.directory?(dir_upload)
    FileUtils.mkdir_p(dir_upload)
  end
  File.open(target, 'wb') {|f| f.write tempfile.read }


  client_user.nickname = nickname
  DBUpdate.update_client_user(client_user)

  puts "token uuid :#{token}"
  "#{{:token => token}.to_json}"

end




get '/cartoons/list' do
  #/cartoons/list?param={"main":{"count":20,"page":1,"descend":true},"extend":{"version":"1.0"}}
  request_json = params[:param]
  puts "request_json :#{request_json}"

  parsedJson = JSON.parse(request_json)


  count = parsedJson["main"]["count"].to_i
  page = parsedJson["main"]["page"].to_i
  descend = parsedJson["main"]["descend"].to_bool

  puts "count :#{count}  page:#{page}  descend:#{descend}"

  start_position = page*count
  if descend
    order_method = :desc
  else
    order_method = :asc
  end
  books = Book.order(id: order_method).limit(count).offset(start_position)

"#{{:books => books}.to_json}"

end


#weixin
get '/cartoon/:id' do
  cartoon_id = params[:id].to_i
  cartoon = Cartoon.find(cartoon_id)
  haml :cartoon,:locals => { :title =>cartoon.title, :picture_url =>cartoon.picture_url}

end


