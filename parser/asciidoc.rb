require './parser/asciielement.rb'
require './parser/asciilines.rb'
require './parser/asciiplugins.rb'
# require plugins first
Dir["./parser/standard/*.rb"].each {|file| require file }

class AsciiDoc
  
  include AsciiPlugins

  def initialize(content)
    @element = AsciiElement.new
    @lines = AsciiLines.new(content)
    parse_lines
  end
  
  private
  
  def parse_lines
    detect_plugins
    while @lines.next_line do
      detect_plugins
    end
  end
  
  def detect_plugins()
    Plugins.each do |p|
      if p[:regexp] =~ @lines.current_line
        puts "Matched something"
        # if match, then call the handler with the Asciilines src and the element to push into
      end
    end
  end
  
  def parse_titles
    @config["titles"].each do |k,v|
      #@html.gsub!(v, template(k))
      @html.gsub!(v, '<h1>\k<title></h1>')
    end
  end
  
end