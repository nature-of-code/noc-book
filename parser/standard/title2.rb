plugin = {
  :name => :title2,
	:regexp  => /^=== +(?<title2>[\S].*?)( +===)?$/,
	:handler => lambda { |lines, element|
    title = AsciiElement.new(plugin[:name])
    title.children << lines.current_line.gsub!(plugin[:regexp], '\k<title2>')
    element.children << title
	}
}

AsciiPlugins::register(plugin)