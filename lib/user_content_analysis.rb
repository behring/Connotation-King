module ContentAnalysis
	def self.analysis_content_type(content)
		
		case content
			when "?","？"
				USER_CONTENT_TYPE_WHY
			when "1"
				USER_CONTENT_TYPE_CARTOON
			when "2"
				USER_CONTENT_TYPE_JOKE
			when "3"
				USER_CONTENT_TYPE_JZW
			when "4"
				USER_CONTENT_TYPE_MUSIC
			when "cx"
				USER_CONTENT_TYPE_CX
			else
				if content.include?('内含王我爱你')
							USER_CONTENT_TYPE_JZW_ANSWER
				elsif content.include?('+')
					singer_song_array = content.split('+')
					if singer_song_array.size == 2
						USER_CONTENT_TYPE_MUSIC_SEARCH

					else
						USER_CONTENT_TYPE_ERROR
					end

				end
		end
	end
end