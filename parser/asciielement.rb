class AsciiElement
  
  attr_accessor :children, :type
  
  def initialize(type)
    @type = type
    @children = []
  end
  
  def test_output
    out = ""
    @children.each do |child|
      if(child.is_a? String)
        out += child
      else
        out += child.test_output
      end
    end
    out
  end
  
end