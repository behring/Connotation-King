require 'rubygems'
require 'sinatra'
require 'wei-backend'
require 'nokogiri'
require 'open-uri'
require 'haml'
require 'sinatra/activerecord'

require_relative '../lib/grab_data'
require_relative '../app/controllers/index_controller'
require_relative '../app/controllers/application_controller'
require_relative '../app/app.rb'




configure :development do
 set :database, 'sqlite:///dev.db'
 set :show_exceptions, true
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end