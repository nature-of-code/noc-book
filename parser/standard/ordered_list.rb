plugin = {
  :name => :ordered_list,
	:regexp  =>  /^.\s{1}/,
	:handler => lambda { |lines, element|
    
    ordered_list = AsciiElement.new(plugin[:name])
    
    item = lines.current_line
    
    while(lines.shift_line) do
      break if lines.current_line =~ /^\s*$/ && !(lines.next_line =~ plugin[:regexp])
      item += lines.current_line
      
      # if next is new bullet
      if lines.next_line =~ plugin[:regexp]
        item.gsub!(plugin[:regexp], "")
        ordered_list.children << item
        item = ""
      end
      
    end
    
    item.gsub!(plugin[:regexp], "")
    ordered_list.children << item
    element.children << ordered_list
	}
}

AsciiPlugins::register(plugin)