class AsciiDoc
  
  attr_accessor :html, :config
  
  def initialize(content)
    @config = YAML::load(open("config.yml").read)
    @html = content
    parse_titles
  end
  
  private
  
  def parse_titles
    @config["titles"].each do |k,v|
      @html.gsub!(v, '<h1>\k<title></h1>')
    end
  end
  
end