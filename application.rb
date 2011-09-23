require 'rubygems'
require 'bundler'
Bundler.require
require './parse'
require 'yaml'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/parse' do
    @parser = Parse.new(open("public/test.asciidoc").read)
    erb :parse
  end

  not_found do
    erb :notfound
  end
  
end



