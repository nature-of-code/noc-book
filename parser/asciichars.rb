class AsciiChars
  
  attr_accessor :current_index, :chars
    
  def initialize(content)
    @current_index = 0
    @chars = content
  end
  
  def shift_char
    @current_index += 1
    current_char
  end
  
  def prev_char(num = 1)
    @chars[@current_index - 1, num]
  end
  
  def next_char(num = 1)
    @chars[@current_index + 1, num]
  end
  
  def current_char
    @chars[@current_index, 1]
  end
  
end