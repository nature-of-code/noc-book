plugin = {
  :name => :source,
	:regexp  => /^\[source,[a-z]+\]$/,
	:handler => lambda { |lines, element|
    
    unless lines.next_line =~ /^-{3,}$/
      return false
    end
    
    body = ""
    
    while(lines.next_line) do
      break if lines.current_line =~ /^-{3,}$/
      body += lines.current_line
    end
    
    source = AsciiElement.new(plugin[:name])
    source.children << "Java"
    source.children << body
    
    element.children << source
	}
}

AsciiPlugins::register(plugin)