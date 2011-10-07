plugin = {
  :name => :paragraph,
	:regexp  =>  /^\w+/,
	:handler => lambda { |lines, element|
    
    body = lines.current_line
    
    while(lines.shift_line) do
      break if lines.current_line =~ /^\s*$/
      body += lines.current_line
    end
    
    paragraph = AsciiElement.new(plugin[:name])
    paragraph.children << body
    element.children << paragraph
	}
}

AsciiPlugins::register(plugin)