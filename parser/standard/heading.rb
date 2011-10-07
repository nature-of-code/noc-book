plugin = {
  :order => 1,
  :name => :title1,
	:regexp  => /^\w+/,
	:handler => lambda { |lines, element|
  
    
    # unless lines.next_line =~ /^={3,}$/
    #      return false
    #    end
    
    return false
    
	}
}

AsciiPlugins::register(plugin)