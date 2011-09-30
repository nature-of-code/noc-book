plugin = {
  :name => :title4,
	:regexp  => /^===== +(?<title4>[\S].*?)( +=====)?$/,
	:handler => lambda { |lines, element|
    title = AsciiElement.new(plugin[:name])
    title.children << lines.current_line.gsub!(plugin[:regexp], '\k<title4>')
    element.children << title
	}
}

AsciiPlugins::register(plugin)