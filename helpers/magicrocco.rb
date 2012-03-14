class MagicRocco < Rocco
  def initialize(filename, language, syntax_on=false)
    @file       = filename

    # When `block` is given, it must read the contents of the file using
    # whatever means necessary and return it as a string. With no `block`,
    # the file is read to retrieve data.
    @data = filename

    @options =  {
      :template_file => nil,
      :language => language || "java",
      :comment_chars => "//",
      :syntax_on => syntax_on
    }
    @options[:language] = detect_language
    @options[:comment_chars] = generate_comment_chars

    # Turn `:comment_chars` into a regex matching a series of spaces, the
    # `:comment_chars` string, and the an optional space.  We'll use that
    # to detect single-line comments.
    @comment_pattern = Regexp.new("^\\s*#{@options[:comment_chars][:single]}\s?")

    # `parse()` the file contents stored in `@data`.  Run the result through
    # `split()` and that result through `highlight()` to generate the final
    # section list.
    @sections = highlight(split(parse(@data)))
  end
  
  def detect_language
    @_language ||=
      if pygmentize?
        %x[pygmentize -N thing.#{@options[:language]}].strip.split('+').first
      else
        "text"
      end
  end
  
  # Take the result of `split` and apply syntax highlighting to source code.
  def highlight(blocks)
    docs_blocks, code_blocks = blocks

    # Pre-process Docblock @annotations.
    docs_blocks = docblock(docs_blocks) if @options[:docblocks]

    # We are skipping markdown formatting and passing comments as
    # plain text. Here would be the place to apply ASCIIDOC formatting
    docs_html = docs_blocks

    # Combine all code blocks into a single big stream with section dividers and
    # run through either `pygmentize(1)` or <http://pygments.appspot.com>
    span, espan = '<span class="c.?">', '</span>'
    if @options[:comment_chars][:single]
      front = @options[:comment_chars][:single]
      divider_input  = "\n\n#{front} DIVIDER\n\n"
      divider_output = Regexp.new(
        [ "\\n*",
          span,
          Regexp.escape(CGI.escapeHTML(front)),
          ' DIVIDER',
          espan,
          "\\n*"
        ].join, Regexp::MULTILINE
      )
    else
      front = @options[:comment_chars][:multi][:start]
      back  = @options[:comment_chars][:multi][:end]
      divider_input  = "\n\n#{front}\nDIVIDER\n#{back}\n\n"
      divider_output = Regexp.new(
        [ "\\n*",
          span, Regexp.escape(CGI.escapeHTML(front)), espan,
          "\\n",
          span, "DIVIDER", espan,
          "\\n",
          span, Regexp.escape(CGI.escapeHTML(back)), espan,
          "\\n*"
        ].join, Regexp::MULTILINE
      )
    end

    code_html =
      if @options[:syntax_on]
        code_stream = code_blocks.join(divider_input)
        if pygmentize?
          highlight_pygmentize(code_stream)
        else
          highlight_webservice(code_stream)
        end
      else
        code_blocks.join(divider_input)
      end

    # If syntax_on is true then after pygmentize the divider_input
    # has been altered to the form of divider_output, otherwise its
    # still the same.
    code_divider = 
      if @options[:syntax_on]
        divider_output
      else
        divider_input
      end

    # Do some post-processing on the pygments output to split things back
    # into sections and remove partial `<pre>` blocks.
    code_html = code_html.
      split(code_divider).
      map { |code| code.sub(/\n?<div class="highlight"><pre>/m, '') }.
      map { |code| code.sub(/\n?<\/pre><\/div>\n/m, '') }

    # Wrap every line of code in spans with class "one-line"
    code_html = code_html.
      map { |code| code.gsub(/(?<code>.*[^\n$])(?<end>\n|$)/,"<span class='one-line'>" + '\k<code>' + "</span>" + '\k<end>') }

    # Lastly, combine the docs and code lists back into a list of two-tuples.
    docs_html.zip(code_html)
  end
  
  def render(template)
    ERB.new(template).result(binding)
  end
end