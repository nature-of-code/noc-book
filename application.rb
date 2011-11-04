require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/parse' do
    @document = AsciiDoc::AsciiDocument.new(open("public/test.asciidoc").read)
    erb :parse
  end

  not_found do
    erb :notfound
  end
  
end



