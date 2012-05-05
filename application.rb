require 'rubygems'
require 'bundler'
Bundler.require
require './helpers/magicrocco'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    
    @document = AsciiDoc::AsciiDocument.new("templates/test.asciidoc")
    
    # Render via default templates
    @html = @document.render(:html)
    
    # Render via custom templates
    #@html = @document.render(:html, "templates/html")
    
    # Render to file via default templates
    #@html = @document.render(:html, false, "public/results/html/index.html")
    
    # Render to file via custom templates
    #@html = @document.render(:html, "templates/html", "public/results/html/index.html")
    
    #redirect "results/html/index.html"
    
    @html
    
  end
  
  get '/create_pdf' do
    
    args = []
    args << { :option => "--header-html", :value => "templates/oreilly_print/views/header.html"}
    args << { :option => "--header-spacing", :value => 10} # make space between header and content
    args << { :option => "--margin-top", :value => 30} # the header spacing moves the header up, so push it down again
    
    @document = AsciiDoc::AsciiDocument.new("templates/test.asciidoc")
    @document.render(:pdf, "templates/oreilly_print", "public/results/oreilly_print", args)
    redirect "results/oreilly_print/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



