plugin = {
  :name => :title1,
	:regexp  => /^== +(?<title1>[\S].*?)( +==)?$/,
	:handler => lambda { |lines, element|
    title = AsciiElement.new(plugin[:name])
    title.children << lines.current_line.gsub!(plugin[:regexp], '\k<title1>')
    element.children << title
	}
}

AsciiPlugins::register(plugin)