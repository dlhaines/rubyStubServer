require 'simplecov'
#require_relative '../Logging'
## The SD Logger class must be required before including this TestHelper class.
## It should NOT be included directly in a test class itself.  It should be included
## by including the class under test.

SimpleCov.start do
  filters.clear
  add_filter "/.rvm/"
  add_filter "/RubyMine.app/"
  add_filter do |source_file|
    false
  end
end

#include Logging
require_relative '../Logging'

#### setup test environment
require 'minitest'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/reporters'
require 'shoulda'
#require 'shoulda/context'
# require 'webmock/minitest'

reporter_options = { color: false }

# default output
#MiniTest::Reporters.use!
# default without color
#reporter_options = { color: true }
#MiniTest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

# spec type output
MiniTest::Reporters.use! [Minitest::Reporters::SpecReporter.new(reporter_options)]


### setup utility methods
class TestHelper < Object

  # store a global default log level that test files can
  # look up and share.
  @@log_level = Logger::Severity::WARN
  #@@log_level  = Logger::Severity::DEBUG

  def self.getCommonLogLevel
    return @@log_level
  end

  ## return a fully qualified path to the test file directory
  ## It assumes standard locations and looking for directory with name 'test-files'
  def self.findTestFileDirectory
    currentDirectory = Dir.pwd()

    checkDir = "#{currentDirectory}/test-files"
    #puts "checkDir: A: #{checkDir}"
    return checkDir if Dir.exist?(checkDir);

    #checkDir = File.dirname(currentDirectory)+"/test/test-files"
    checkDir = "#{currentDirectory}/test/test-files"
    #puts "checkDir: B: #{checkDir}"
    return checkDir if Dir.exist?(checkDir);

    # didn't find anything.
    puts "CAN NOT FIND TEST FILE DIRECTORY: current dir: #{currentDirectory}"
    exit 1
  end

  ## return a fully qualified path to the directory with the security file.
  ## It assumes standard locations and looking for directory with name 'test-files'
  def self.findSecurityFile(file_name)
    currentDirectory = Dir.pwd()

    checkFile = "#{currentDirectory}/#{file_name}"
    return checkFile if File.exist?(checkFile);

    checkFile = currentDirectory+"/server/spec/#{file_name}"
    return checkFile if File.exist?(checkFile);

    puts "CAN NOT FIND SECURITY FILE: #{file_name}";
    exit 1
  end

end
