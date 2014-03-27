module JzwGrab
  def self.grab_jzw
    #急转弯网站笑话一共74页，url从1到74
    page_number = Random.rand(1..74)
    url = "http://www.2345.com/jzw/#{page_number}.htm"


    page = Nokogiri::HTML(open(URI.encode(url)))

    node_jzw_count = page.css('div.jzw_container ul li').size
    jzw_row_number = Random.rand(node_jzw_count)#包含0不包含node_jzw_count

    #拿到每一个急转弯的节点
    page.css('div.jzw_container ul li').each_with_index do |node_jzw,index|

      #抓取急转弯问题
      node_qustion = node_jzw.css('span')[0].text.to_s
      qustion = node_qustion.encode("UTF-8")
      #抓取急转弯答案
      node_answer = node_jzw.css('span')[1].to_s
      node_answer = node_answer.encode("UTF-8")
      parser = Nokogiri.parse(node_answer)
      answer = parser.xpath('//a[@onclick]').first.attributes['onclick'].content.match(/'([^']+)/)[1]

      jzw = Jzw.new
      jzw.page_row_number= page_number.to_s+"."+index.to_s
      jzw.qustion = qustion
      jzw.answer = answer
      DBHelper::DBAdd.add_jzw(jzw)

      if index == jzw_row_number
        @jzw_return = jzw
      end
    end
    @jzw_return
  end

end