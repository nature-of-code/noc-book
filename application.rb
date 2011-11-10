require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/parse' do
    @document = AsciiDoc::AsciiDocument.new(open("public/test.asciidoc").read)
    @document.render(:html, "templates/html_template", "results/html")
  end
  
  get '/parse_pdf' do
    `wkhtmltopdf http://localhost:9393/parse my.pdf`
  end

  not_found do
    erb :notfound
  end
  
end



