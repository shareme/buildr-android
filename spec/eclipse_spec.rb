# this is called a context (or a describe block)
require File.dirname(__FILE__) + '/spec_helpers.rb'

describe Eclipse do
  
  before(:each) do
  end

  it "should get the type of project from options" do    
    define 'root' do
      include Android
      
      define 'foo', :android_type => :robolectric do
      end
      
      define 'bar', :android_type => :instrumentation do
      end
    end
    project('root:foo').android_type.should eql(:robolectric)
    project('root:bar').android_type.should eql(:instrumentation)
  end
end
