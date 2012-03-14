require 'rubygems'
require 'bundler'
Bundler.require

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    @document = AsciiDoc::AsciiDocument.new("templates/book.asciidoc")   
    @document.render(:html, "templates/html", "public/results/html")
    redirect "results/html/index.html"
  end
  
  get '/create_pdf' do
    
    args = []
    args << { :option => "--header-html", :value => "templates/html_template/views/header.html"}
    args << { :option => "--header-spacing", :value => 10} # make space between header and content
    args << { :option => "--margin-top", :value => 30} # the header spacing moves the header up, so push it down again
    
    @document = AsciiDoc::AsciiDocument.new("templates/test.asciidoc")
    @document.render(:pdf, "templates/print", "public/results/print", args)
    redirect "results/print/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



