plugin = {
  :name => :bulleted_list,
	:regexp  =>  /^-\s{1}/,
	:handler => lambda { |lines, element|
    
    body = lines.current_line
    
    while(lines.shift_line) do
      break if lines.current_line =~ /^\s*$/
      body += lines.current_line
    end
    
    body = body.split("- ")
    body.keep_if { |child| not child.empty?}
    
    bulleted_list = AsciiElement.new(plugin[:name])
    bulleted_list.children = body
    element.children << bulleted_list
	}
}

AsciiPlugins::register(plugin)