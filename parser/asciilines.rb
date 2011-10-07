class AsciiLines
  
  attr_accessor :current_index, :lines
    
  def initialize(content)
    @current_index = 0
    @lines = content.gsub("\r","").split("\n")
  end
  
  def shift_line
    @current_index += 1
    current_line
  end
  
  def prev_line
    @lines[@current_index - 1]
  end
  
  def next_line
    @lines[@current_index + 1]
  end
  
  def current_line
    @lines[@current_index]
  end
  
end