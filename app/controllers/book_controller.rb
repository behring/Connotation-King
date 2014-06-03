get '/book/old_data' do
  #/cartoons/list?param={"main":{"count":20,"oldest_book_id":134,"descend":true},"extend":{"version":"1.0"}}
  request_json = params[:param]
  puts "request_json :#{request_json}"
  parsedJson = JSON.parse(request_json)

  count = parsedJson["main"]["count"].to_i
  oldest_book_id = parsedJson["main"]["oldest_book_id"].to_i
  descend = parsedJson["main"]["descend"].to_bool

  puts "count :#{count}  oldest_book_id:#{oldest_book_id}  descend:#{descend}"

  if descend
    order_method = :desc
  else
    order_method = :asc
  end
  books = Book.order(id: order_method).where("volume_number < #{oldest_book_id}").limit(count)

  "#{{:books => books}.to_json}"
end

get '/book/new_data' do

  request_json = params[:param]
  puts "request_json :#{request_json}"
  parsedJson = JSON.parse(request_json)

  count = parsedJson["main"]["count"].to_i
  newest_book_id = parsedJson["main"]["newest_book_id"].to_i
  descend = parsedJson["main"]["descend"].to_bool

  puts "newest_book_id:#{newest_book_id}  descend:#{descend}"


  if descend
    order_method = :desc
  else
    order_method = :asc
  end

  if newest_book_id==-1
    books = Book.order(id: order_method).limit(count).offset(0)
  else
    books = Book.order(id: order_method).where("volume_number > #{newest_book_id}")
  end

  "#{{:books => books}.to_json}"

end


