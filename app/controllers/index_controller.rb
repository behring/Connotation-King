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
"#music URL：{music.url}"
  # song = "冰雨"
  # singer = "刘德华"
  # music = BaiduMusic.get_music(singer,song)
  # "#{music.url}\n\n\n\n\n#{music.durl}"

end


get '/index' do
"你好，我是内含王！"
#haml :postgres_test
end


get '/bucket/*' do

	request_path = params[:splat][0]
	s3 = AWS::S3.new
	puts "get an instance of the S3 interface."
	puts "remove bucket #{BUCKET_NAME} if exist"
	bucket = s3.buckets[BUCKET_NAME]

	# bucket.objects.each do |obj|
 #  		puts obj.key
	# end
  cartoon_books = bucket.objects.with_prefix(BUCKET_DATA_CARTOON)
  cartoon_covers = bucket.objects.with_prefix(BUCKET_IMAGES_CARTOON_COVER)
  puts "cartoon_books count:#{cartoon_books.count}   cartoon_books count:#{cartoon_covers.count}"
  cartoon_books.each_with_index do |s3_book,index|
    if index>0
      book = Book.new
      book.book_url= s3_book.public_url.to_s
      book.cover_url = cartoon_covers[index].public_url.to_s
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

	"DDD"
end

get '/cartoons/list' do
 # matches "GET /posts?page=2&count=40&descend = false"
  page = params[:page]
  count = params[:count]
  descend = params[:descend]


  "page :#{page}   count:#{count}   descend :#{descend}"
end


#weixin
get '/cartoon/:id' do
  cartoon_id = params[:id].to_i
  cartoon = Cartoon.find(cartoon_id)
  haml :cartoon,:locals => { :title =>cartoon.title, :picture_url =>cartoon.picture_url}

end


