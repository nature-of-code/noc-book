AsciiPlugins::register(
	:name => :title0,
	:regexp  => /^== +(?<title>[\S].*?)( +==)?$/,
	:handler => lambda { |doc, src, context|
     # handle parsing here
	}
)