plugin = {
  :name => :quote,
	:regexp  => /^\[quote\]$/,
	:handler => lambda { |lines, element|
    
    body = ""
    
    while(lines.next_line) do
      break if lines.current_line =~ /^\s*$/
      body += lines.current_line
    end
    
    quote = AsciiElement.new(plugin[:name])
    quote.children << body
    element.children << quote
    
	}
}

AsciiPlugins::register(plugin)