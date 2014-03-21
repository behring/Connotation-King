get '/index' do
"你好，我是内含王！"

end

get '/cartoon/:id' do
  cartoon_id = params[:id].to_i
  cartoon = Cartoon.find(cartoon_id)
  haml :cartoon,:locals => { :title =>cartoon.title, :picture_url =>cartoon.picture_url}


end


