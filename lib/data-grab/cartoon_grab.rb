module CartoonGrab
  def self.grab_cartoon(url)
    cartoon = Cartoon.new

    page = Nokogiri::HTML(open(URI.encode(url)))
    img_node = page.css('div#imgshowdiv img')[0]
    if img_node==nil
      random_cartoon_url = page.css('div.zw_page2 a')[0]['href']
      self.grab_cartoon(random_cartoon_url)

    else
      cartoon.title = img_node['alt']
      cartoon.picture_url = img_node['src']
      other_urls =  "#{page.css('div.zw_page1 a')[0]['href']} #{page.css('div.zw_page2 a')[0]['href']} #{page.css('div.zw_page3 a')[0]['href']}"
      cartoon.description = page.css('div#imgshowdiv span')[0].text
      cartoon.other_urls = other_urls
      cartoon.url = url
    end
    DBHelper::DBAdd.add_cartoon(cartoon)
    cartoon
  end

end