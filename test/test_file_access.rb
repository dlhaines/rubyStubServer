#require 'rubygems'
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

class FileAccessTest < Minitest::Test


  # Called before every test method runs. Can be used
  # to set up fixture information.
  # def setup
  #   # Do nothing
  # end
  #
  # # Called after every test method runs. Can be used to tear
  # # down fixture information.
  #
  # def teardown
  #   # Do nothing
  # end

  context "EXISTING FILES" do
    # could have block for 'setup' and 'teardown'
    should "test fail" do
      #skip "known to fail"
      assert_equal('a','b')
    end

    should "test pass" do
      assert_equal('a','a')
    end
  end

  context "MISSING FILES" do
    # could have block for 'setup' and 'teardown'
    should "test fail" do
      #skip "known to fail"
      assert_equal('a','b')
    end

    should "test pass" do
      assert_equal('a','a')
    end
  end

end
