get '/index' do
	enc   = Base64.encode64("http://ww3.sinaimg.cn/large/6b269d7dtw1ea6y4sxj63j20e628dk68.jpg")
                    # -> "U2VuZCByZWluZm9yY2VtZW50cw==\n"
	plain = Base64.decode64(enc)
                    # -> "Send reinforcements"
    "encode :#{enc}</br> decode :#{plain}"

 # cartoon_url = DBHelper.get_last_cartoon_url
 # page_cartoon = Nokogiri::HTML(open(cartoon_url))
	# 	img_node = page_cartoon.css('div#imgshowdiv img')[0].class
 # "#{img_node}"
end

get '/cartoon/:base64url' do

  # Post.create(title: "behring", body: "hahahahahaha.")
  # posts = Post.order("created_at DESC")
  # haml :postgres_test,  :locals => { :data =>posts}
  encode_url = params[:base64url]
  picture_url = Base64.decode64(encode_url)
  # "encode_picture :#{encode_url}</br> decode_picture :#{picture_url}"
  haml :cartoon,  :locals => { :picture_url =>picture_url}


end


