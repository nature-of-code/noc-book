AsciiPlugins::register(
	:name => :title0,
	:regexp  => /^= +(?<title0>[\S].*?)( +=)?$/,
	:handler => lambda { |doc, src, context|
     # handle parsing here
	}
)