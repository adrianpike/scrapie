require 'helper'

ShamRack.at("scrapietest").sinatra do
  get "/test1" do
    "No attributes here chief"
  end
  get "/test_with_params" do
    "<div id='param'>#{params[:test_param_for_getting]}</div><div id='param_upcased'>#{params[:test_param_for_getting].upcase}</div>"
  end
  get "/test" do
    "<div class='foo'>example</div>"
  end
  get '/500' do
    DERP
  end
  post '/post' do
    "<div id='post_param'>#{params[:le_post]}</div>"
  end
end

class NoAttributeScrapie < Scrapie
  url 'http://scrapietest/test1'
end

class BasicScrapie < Scrapie
  url 'http://scrapietest/test'
  attributes({ 'foo' => '.foo' })
end

class ParamsScrapie < Scrapie
  url 'http://scrapietest/test_with_params'
  params({ :test_param => 'test_param_for_getting' })
  attributes({
    'param' => 'div#param',
    :param_upcased => 'div#param_upcased'
  })
end

class FourOhFourScrapie < Scrapie
  url 'http://scrapietest/ends_of_the_earth'
  attributes({
    'results' => 'div#post_param'
  })
end

class FiveHundredScrapie < Scrapie
  url 'http://scrapietest/500'
  attributes({
    'results' => 'div#post_param'
  })
end

class PostScrapie < Scrapie
  url 'http://scrapietest/post'
  http_method :post
  
  params({ :search => 'le_post' })
  attributes({
    'results' => 'div#post_param'
  })
end

describe Scrapie do
  
  it 'whines if you don\'t specify any attributes' do
    lambda { nas = NoAttributeScrapie.find(:har => 'heh') }.should raise_error(Scrapie::NoAttributesException)
  end
  
  it 'does a basic fetch sans params' do
    basic = BasicScrapie.find
    basic.foo.should == 'example'
  end
  
  it 'handles params' do
    test_string = 'sdkfjhdsafjkladhfklzxcv123' # todo: random string
    
    paramtest = ParamsScrapie.find(:test_param => test_string)
    paramtest.param.should == test_string
    paramtest.param_upcased.should == test_string.upcase
  end
  
  it 'handles 404s' do
    lambda { nas = FourOhFourScrapie.find(:har => 'heh') }.should raise_error(Mechanize::ResponseCodeError)
  end
  it 'handles 500s' do
    lambda { nas = FiveHundredScrapie.find(:har => 'heh') }.should raise_error(Mechanize::ResponseCodeError)
  end
  it 'uses different HTTP methods' do
    post = PostScrapie.find(:search => 'le_search')
    
    post.results.should == 'le_search'
  end
  
  it 'uses a before_fetch'
  it 'uses an after_fetch'
  it 'sets agent options'

end
