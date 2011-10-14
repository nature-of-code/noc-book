module AsciiCharPlugins
  
  CharPlugins = []
  
  def self.register(plugin)
    CharPlugins << plugin
  end
  
  def order_plugins
    CharPlugins.sort! do |x,y| 
      x_val = x.has_key?(:order) ? x[:order] : 99999999999
      y_val = y.has_key?(:order) ? y[:order] : 99999999999
      x_val <=> y_val
    end
  end
  
end