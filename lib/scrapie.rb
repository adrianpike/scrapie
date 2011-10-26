require 'mechanize'

class Scrapie
  class ScrapieException < Exception; end
  class NoAttributesException < ScrapieException; end
  
  def self.url(url)
    @url = url
  end
  def self.params(params)
    @params = params
  end
  def self.http_method(method)
    @http_method = method
  end
  def self.attributes(attributes)
    @attributes = attributes
    attributes.each {|name,page_selector|
      self.send(:attr_accessor, name)
    }
  end
  
  # find()
  # find(:foo => bar)
  # find(:foo => bar, :baz => bizzle)  
  def self.find(opts = {})
    raise NoAttributesException unless (@attributes and @attributes.size > 0)
    a = Mechanize.new
    
    # Let's build out the parameters now
    params = Hash[opts.collect{|k,v|
      [@params[k], v] if @params and @params[k]
    }]
    
    page = a.send(@http_method || :get, @url, params)
    
    new_object = self.new
    @attributes.each {|name, page_selector|
      new_object.send(name + '=', page.search(page_selector).inner_html)
    }
    
    new_object
  end
  
  # Callbacks # TODO
  
  def self.before_fetch
    
  end
  
  def self.after_fetch
    
  end
  
end