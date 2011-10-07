plugin = {
  :name => :image,
  :order => 2,
	:regexp  => /^image:{1}(?<path>[\S]+)\[(?<alt>[\S\s]+)\]$/,
	:handler => lambda { |lines, element|    
    image = AsciiElement.new(plugin[:name])
    image.children << lines.current_line.gsub(plugin[:regexp], '\k<path>')
    image.children << lines.current_line.gsub(plugin[:regexp], '\k<alt>')
    element.children << image
	}
}

AsciiPlugins::register(plugin)