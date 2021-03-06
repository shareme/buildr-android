require File.expand_path(File.join(File.dirname(__FILE__), '../..', 'spec_helpers'))

describe Buildr::Robolectric do
  
  describe "Robolectric" do
    
    before do
      # ensure we are seen as android
      write 'AndroidManifest.xml'
    end
    
    it 'should apply robolectric to project with manifest file and unit layout defined' do
      write 'tests/java/HelloWorld.java'
      define 'foo', :layout => Buildr::Android::Layout.new
      File.should be_exist(project('foo')._('AndroidManifest.xml'))
      File.should be_exist(project('foo')._(:source, :test, :java))
    end
    
    it 'should have robolectric if manually defined' do 
      define 'foo' do
        test.using(:robolectric)
        test.framework.should eql(:robolectric)
      end
    end

    it 'should have robolectric if layout folder contains unit test' do
      write 'tests/java/HelloTest.java'
      define 'foo', :layout => Buildr::Android::Layout.new
      project('foo').test.framework.should eql(:robolectric)
    end
    
    it 'should put robolectric in front of dependency list' do
     # write 'tests/java/HelloTest.java'
      #define ('foo') { test.with :robolectic }
    #  project('foo').test.dependencies.first.should eql("com.pivotallabs:robolectric:jar")
    end
  end
end