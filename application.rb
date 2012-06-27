require 'rubygems'
require 'bundler'
Bundler.require
require './helpers/magicrocco'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html/:filename' do
    # TODO: Make is possible to specify array of templates. Later views will override older views.    
    @document = AsciiDoc::AsciiDocument.new("public/#{params[:filename]}", { :debug_xml_to_file => "public/#{params[:filename]}.xml" })
    @document.render(:html, :template => "public/noc_html/views", :output => "public/noc_html/index.html")
    redirect "noc_html/index.html"
  end
  
  get '/create_pdf/:filename' do
    
    # first render html
    @document = AsciiDoc::AsciiDocument.new("public/#{params[:filename]}", { :debug_xml_to_file => "public/#{params[:filename]}.xml" })
    @document.render(:html, :template => "public/noc_pdf/views", :output => "public/noc_pdf/index.html")
    @document.render(:pdf, :html_file => "public/noc_pdf/index.html", :output => "public/noc_pdf/index.pdf")
    redirect "noc_pdf/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



