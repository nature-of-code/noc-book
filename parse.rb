class Parse
  
  attr_accessor :parsed_content, :config
  
  def initialize(content)
    @config = YAML::load(open("config.yml").read)
    @parsed_content = content
    parse_titles
  end
  
  private
  
  def parse_titles
    @config["titles"].each do |k,v|
      @parsed_content.gsub!(v, '<h1>\k<title></h1>')
    end
  end
  
end