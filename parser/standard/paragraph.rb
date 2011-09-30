plugin = {
  :name => :paragraph,
	:regexp  =>  /^\w+/,
	:handler => lambda { |lines, element|
    
    body = lines.current_line
    
    while(lines.next_line) do
      if lines.current_line =~ /^\s*$/
        # lines.next_line  # remove whitespace
        break
      end
      body += lines.current_line
    end
    
    paragraph = AsciiElement.new(plugin[:name])
    paragraph.children << body
    element.children << paragraph
	}
}

AsciiPlugins::register(plugin)