require './parser/asciielement.rb'
require './parser/asciilines.rb'
require './parser/asciiplugins.rb'
# require plugins first
Dir["./parser/standard/*.rb"].each {|file| require file }

class AsciiDoc
  
  include AsciiPlugins

  def initialize(content)
    @element = AsciiElement.new(:document)
    @lines = AsciiLines.new(content)
    parse_lines
  end
  
  def render(template, format)
    views = {}
    Dir["./templates/#{template}/#{format}/*.html.erb"].each { |file| 
      symbol = file.split("/").last.split(".").first.to_sym
      views[symbol] = "Hello"
      # require file 
    }
    views
  end
  
  def test_output
    @element.test_output
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
        if p[:handler].call(@lines, @element)
          break
        end
      end
    end
  end
  
end