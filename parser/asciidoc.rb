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
      views[symbol] = ERB.new(open(file).read)
    }
    result = @element.render(views)
    result
  end
  
  private
  
  def parse_lines
    order_plugins
    detect_plugins
    while @lines.shift_line do
      unless @lines.current_line =~ /^\s*$/
        detect_plugins
      end
    end
  end
  
  def detect_plugins()
    found = false
    Plugins.each do |p|
      if p[:regexp] =~ @lines.current_line
        if p[:handler].call(@lines, @element)
          found = true
          break
        end
      end
    end
    unless found
      puts "#{@lines.current_index} out of #{@lines.lines.size}"
      @element.children << "NOT FOUND: " + @lines.current_line
    end
  end
  
end