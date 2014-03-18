require 'rubygems'
require 'sinatra'
require 'wei-backend'
token "connotation-king"

get '/index' do
	"hello sinatra"
end

on_text do
    "你发送了如下内容:  #{params[:Content]}"
end

on_subscribe do
    "感谢您订阅“内含王”，希望每天为您带来开心！"
end