class AsciiLines
  
  def initialize(content)
    @current_line = 0
    @lines = content.gsub("\r","").split("\n")
  end
  
  def next_line
    @current_line += 1
    current_line
  end
  
  def current_line
    @lines[@current_line]
  end
  
end