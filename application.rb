require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end

  not_found do
    erb :notfound
  end
  
end



