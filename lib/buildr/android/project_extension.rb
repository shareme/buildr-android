module Buildr
  module Android
    module ProjectExtension
      include Extension
      include FileTest
      
      attr_accessor :manifest
      
      first_time do
        @sdk = %w{ ANDROID_HOME }.inject(nil) {|r, v| r = ENV[v] }
        fail "Please set ANDROID_HOME to point to your ANDROID SDK installation" unless @sdk
        @config ||= Buildr::Android::Config.new(self, @sdk)
      end
      
      before_define do |project|
        # this is a android project
        if File.exists?(project._('AndroidManifest.xml'))
            #project.layout = Buildr::Android::Layout.new
          begin
            @manifest = Buildr::Android::Manifest.new(project)
            warn(/no mimimum SDK set/) if @manifest.min_sdk
            project.version = @manifest.version
          rescue
            error("problem with Android project")
          end
        end
      end
      
      after_define do |project|
      end
      
    end
  end
end

module Buildr
  module Android
    class << self
    end
    
    # the ability to define android :
    def android(files, *args)
      options = Hash === args.last ? args.pop.dup : {}
      rake_check_options options, :sdk_home, :sdk_version
      
      sdk_home = options[:sdk_home] || ENV['ANDROID_HOME'] || ENV['ANDROID_SDK']
    end
  end
end
      
  
class Buildr::Project
  include Buildr::Android::ProjectExtension
  include Buildr::Android
end