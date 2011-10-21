require './parser/asciicharplugins.rb'

class AsciiBlock
  
  include AsciiCharPlugins
  
  attr_accessor :element

  def initialize(element)
    @element = element
    @chars = AsciiChars.new(@element.children[0]) # only works when passing an element with a single child (the whole paragraph)
    @element.children[0] = ""
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
      if p[:regexp] =~ @chars.current_char
       if p[:handler].call(@chars, @element)
         found = true
         break
       end
     end
    end
    
    unless found
      if(not @element.children[@element.children.size].is_a?(String))
        @element.children << ""
      end
      @element.children[@element.children.size - 1] << @chars.current_char
    end
  end
  
end