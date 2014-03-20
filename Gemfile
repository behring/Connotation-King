source 'http://ruby.taobao.org'
#source 'http://rubygems.org'
ruby "2.0.0"

gem 'sinatra'
#微信公众平台
gem 'wei-backend'

#grab internet data
gem 'nokogiri'

#orm (对象关系映射库)
gem 'activerecord'
#ports ActiveRecord for Sinatra
gem 'sinatra-activerecord'


gem 'sinatra-flash'
gem 'sinatra-redirect-with-flash'

#http://rubydoc.info/gems/timers/2.0.0/frames
gem "timers", "~> 2.0.0"

group :development do
	gem 'shotgun'
	gem 'sqlite3'
	#provides a Shell for Sinatra so we can interact with our application
	#可以在terminal中给数据库添加数据，测试使用
 	gem 'tux'
end

group :production do
	#postgresql
 	gem 'pg'
end

