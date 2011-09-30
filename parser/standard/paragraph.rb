plugin = {
  :name => :paragraph,
	:regexp  =>  /^\w+/,
	:handler => lambda { |lines, element|
    
    body = lines.current_line
    
    # check for characters that should not be wrapped in <p>, like heading, etc
    # how do we specify that?
    
    while(lines.next_line) do
      break if lines.current_line =~ /^\s*$/
      body += lines.current_line
    end
    
    paragraph = AsciiElement.new(plugin[:name])
    paragraph.children << body
    element.children << paragraph
	}
}

AsciiPlugins::register(plugin)