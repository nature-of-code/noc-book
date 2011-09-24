class AsciiDoc
  
  attr_accessor :html, :config
  
  # TODO: Parse all content in AsciiDoc
  # TODO: Make tags templatable
  
  # pass templates in a templates hash 
  def initialize(content)
    @config = YAML::load(open("config.yml").read)
    @html = content
    parse_titles
    # header
    # header attributes
    # table of contents
    # underlined headings
    # paragraphs
    # blocks
    # text
    # macros
    # lists
    # tables
  end
  
  private
  
  def parse_titles
    @config["titles"].each do |k,v|
      #@html.gsub!(v, template(k))
      @html.gsub!(v, '<h1>\k<title></h1>')
    end
  end
  
end