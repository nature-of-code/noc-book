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
    
    bin_args = []
    # Margins 0.75 inches bottom, left and right, not sure about top yet b/c of header
    bin_args << { :option => "--margin-bottom", :value => 10 }
    bin_args << { :option => "--margin-left", :value => 19.05 }
    bin_args << { :option => "--margin-right", :value => 19.05 }

    # Page dimensions, 7.5x9.25 inches
    bin_args << { :option => "--page-height", :value => 234.95 }
    bin_args << { :option => "--page-width", :value => 190.5 }


    bin_args << { :option => "--header-html", :value => "templates/print/views/header.html"}
    bin_args << { :option => "--header-spacing", :value => 10} # make space between header and content
    bin_args << { :option => "--margin-top", :value => 30} # the header spacing moves the header up, so push it down again
    
    @document.render(:pdf, :html_file => "public/noc_pdf/index.html", :output => "public/noc_pdf/index.pdf", :bin_args => bin_args)
    redirect "noc_pdf/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



