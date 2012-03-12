require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    @document = AsciiDoc::AsciiDocument.new("templates/book.asciidoc")
    @document.render(:html, "templates/html_template", "public/results/html_template")
    redirect "results/html_template/index.html"
  end
  
  get '/create_pdf' do
    @document = AsciiDoc::AsciiDocument.new("templates/test.asciidoc")
    @document.render(:pdf, "templates/html_template", "public/results/pdf_template")
    redirect "results/pdf_template/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



