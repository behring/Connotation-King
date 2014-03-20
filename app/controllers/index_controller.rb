get '/index' do
	# "hello sinatra"

# page = Nokogiri::HTML(open("http://www.xiaojiulou.com/sexi/3639.html")) 
#   "#{page.css('div.zw_page1 a')[0]['href']}
#    #{page.css('div.zw_page2 a')[0]['href']}
#    #{page.css('div.zw_page3 a')[0]['href']}"

  # page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"),nil,'GBK')  
  # p page.css('#text110 p')[0].inner_text

# cartoon_info = GrabData.grab_cartoon("http://www.xiaojiulou.com/sexi/3639.html")

# "#{cartoon_info[:title]}#{cartoon_info[:description]}#{cartoon_info[:picture_url]}"
   
   jokes = GrabData.grab_joke("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm")
   jokes_str = ""
     jokes.each do |joke|
      jokes_str << joke << "</br>"
     end
     "#{jokes_str}" 

end

get '/' do
  # page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"),nil,'GBK')  
  # jokes = GrabData.grab_joke("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm")
  # haml :joke,  :locals => { :jokes =>jokes}
  Post.create(title: "behring", body: "hahahahahaha.")
  posts = Post.order("created_at DESC")

  haml :postgres_test,  :locals => { :data =>posts}
end


