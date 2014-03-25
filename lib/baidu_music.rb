class BaiduMusic
	def self.get_music(singer,song)
		# music = DBHelper.get_music(singer,song)
		# if music != nil
		# 	music
		# else
			#go to baidu interface get a music
			music = request_baidu_inteface(singer,song)
		# end
	end


	private
	def self.request_baidu_inteface(singer,song)

		url = "http://box.zhangmen.baidu.com/x?op=12&count=1&title=#{song}$$#{singer}$$$$"
		p "--------------------------------1-----#{url}--------------------------------"
		
		# response = HTTParty.get(URI.encode(url))
		
		# page = Nokogiri::XML(response.body)
		page = Nokogiri::XML(open(URI.encode(url)),nil,'gb2312')
		# node_encode = page.xpath("/result/url/encode").text
		
		count = page.xpath("/result/count").text.to_i
		p "----------------------------3---------#{count}--------------------------------"
		
		if count>0
			p "-------------------------------has music----------------------------------"
			music = Music.new
			reg_str = /http:\/\/([\w+\.]+)(\/(\w+\/)+)/

			2.times do |index|
				if index == 0
					#普通音乐
					node_encode = page.xpath("/result/url/encode").text
					node_decode = page.xpath("/result/url/decode").text
					encode_result = reg_str.match(node_encode)
					decode_result = node_decode.split('&')[0]
					music.url = "#{encode_result}#{decode_result}"
				else
					#高清音乐
					node_encode = page.xpath("/result/durl/encode").text
					node_decode = page.xpath("/result/durl/decode").text
					encode_result = reg_str.match(node_encode)
					decode_result = node_decode.split('&')[0]
					music.durl = "#{encode_result}#{decode_result}"
				end
				
			end
			# type = page.xpath("/result/p2p/type").text
			music.singer = singer
			music.song = song
	

			DBHelper.add_music(music)
			music
		else
			p "-------------------------------no music----------------------------------"
			
			nil
		end
		


		
	end
end