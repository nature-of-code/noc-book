plugin = {
  :name => :title3,
	:regexp  => /^==== +(?<title3>[\S].*?)( +====)?$/,
	:handler => lambda { |lines, element|
    title = AsciiElement.new(plugin[:name])
    title.children << lines.current_line.gsub!(plugin[:regexp], '\k<title3>')
    element.children << title
	}
}

AsciiPlugins::register(plugin)