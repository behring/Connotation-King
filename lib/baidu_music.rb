module BaiduMusic
	def self.get_music(singer,song)
		#music = DBQuery.get_music(singer,song)
		#if music != nil
		#	music
		#else
			# go to baidu interface get a music
			music = request_baidu_inteface(singer,song)
      music
		#end
	end


	private
	def self.request_baidu_inteface(singer,song)

		url = "http://box.zhangmen.baidu.com/x?op=12&count=1&title=#{song}$$#{singer}$$$$"
    #url = "http://api.map.baidu.com/geocoder?location=40.8248319,111.6604351&coord_type=gcj02&output=xml"
		p "--------------------------------1-----#{url}--------------------------------"


		page = Nokogiri::XML(open(URI.encode(url)),nil,'utf-8')
		count = page.xpath("/result/count").text.to_i
p "----------------------------page body--------|#{page.to_s}|------------------------------"
  
    # xml_data = Net::HTTP.get_response(URI.parse(URI.encode(url))).body
    # p "----------------------------response body--------|#{xml_data.force_encoding('utf-8')}------------------------------"

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
    
     DBAdd.add_music(music)
			music
		else
			p "-------------------------------no music----------------------------------"
    
			nil
		end
	end
end