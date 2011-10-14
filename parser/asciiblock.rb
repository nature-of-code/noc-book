require './parser/asciicharplugins.rb'

class AsciiBlock
  
  include AsciiCharPlugins
  
  attr_accessor :children

  def initialize(element)
    @element = element
    @chars = AsciiChars.new(@element.children[0]) # only works when passing an element with a single child (the whole paragraph)
    parse_chars
  end
  
  private
  
  def parse_chars
    order_plugins
    detect_plugins
    while @chars.shift_char do
      detect_plugins
    end
  end
  
  def detect_plugins
    found = false
    CharPlugins.each do |p|
      if p[:regexp] =~ @lines.current_char
        if p[:handler].call(@chars, @element)
          found = true
          break
        end
      end
    end
    unless found
      @element.children << "NOT FOUND: " + @lines.current_line
    end
  end
  
end