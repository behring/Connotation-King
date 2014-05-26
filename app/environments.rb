require 'rubygems'
require 'sinatra'
require 'wei-backend'
require 'nokogiri'
require 'open-uri'
require 'haml'
require 'net/http'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'aws-sdk'

require_relative '../app/models/cartoon'
require_relative '../app/models/joke'
require_relative '../app/models/jzw'
require_relative '../app/models/music'
require_relative '../app/models/user'

require_relative '../lib/data_type'
require_relative '../lib/db_add'
require_relative '../lib/db_query'
require_relative '../lib/baidu_music'
require_relative '../lib/user_content_analysis'

require_relative '../app/controllers/index_controller'
require_relative '../app/controllers/application_controller'

require_relative './constant'


# require 'timers'
# require_relative '../lib/timer'

puts 'config aws with access account'
AWS.config(
    :access_key_id => 'AKIAIDWEJ2SWVJBCJLLA',
    :secret_access_key => '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'
)
puts 'config finished'


configure :development do

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///neihanwang_db')

  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/neihanwang_db')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end