require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    @document = AsciiDoc::AsciiDocument.new(open("public/test.asciidoc").read)
    @document.render(:html, "templates/html_template", "results/html_template")
  end
  
  get '/create_pdf' do
    `wkhtmltopdf http://localhost:9393/parse my.pdf`
  end

  not_found do
    erb :notfound
  end
  
end



