require 'rubygems'
require 'bundler'
Bundler.require
require './helpers/magicrocco'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    # TODO: Make is possible to specify array of templates. Later views will override older views.    
    @document = AsciiDoc::AsciiDocument.new("public/test.asciidoc", { :debug_xml_to_file => "public/test.xml" })
    @document.render(:html, :template => "public/noc_html/views", :output => "public/noc_html/index.html")
    redirect "noc_html/index.html"
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



