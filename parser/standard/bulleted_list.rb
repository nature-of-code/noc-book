plugin = {
  :name => :bulleted_list,
	:regexp  =>  /^-\s{1}/,
	:handler => lambda { |lines, element|
    
    lis = []
    e = AsciiElement.new(:li)
    e.children <<  lines.current_line.gsub(/^-\s{1}/, "")
    lis << AsciiBlock.new(e).element 
    
    while(lines.shift_line) do
      break if not lines.current_line =~ /^-\s{1}/
      e = AsciiElement.new(:li)
      e.children <<  lines.current_line.gsub(/^-\s{1}/, "")
      lis << AsciiBlock.new(e).element 
    end
    
    bulleted_list = AsciiElement.new(plugin[:name])
    bulleted_list.children = lis
    element.children << bulleted_list
	}
}

AsciiPlugins::register(plugin)