module AsciiPlugins
  
  Plugins = []
  
  def self.register(plugin)
    Plugins << plugin
  end
  
end