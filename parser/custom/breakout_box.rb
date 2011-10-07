# [breakout box]
# [end breakout box]

plugin = {
  :name => :breakout_box,
	:regexp  =>  /^\[breakout box\]{1}$/,
	:handler => lambda { |lines, element|
    
    breakout_box = AsciiElement.new(plugin[:name])
    lines.shift_line
    breakout_box.children << lines.current_line
    lines.shift_line
    
    body = lines.current_line
    
    while(lines.shift_line) do
      break if lines.current_line =~ /^\[end breakout box\]{1}$/
      body += lines.current_line
    end
    
    
    breakout_box.children << body
    element.children << breakout_box
	}
}

AsciiPlugins::register(plugin)