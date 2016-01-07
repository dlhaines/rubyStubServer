require_relative 'test_helper'
require_relative '../stub_helpers'

class TTDTest < Minitest::Test

  context "STATS" do
    ################
    setup do
    end

    teardown do
    end
    ###############
    should_eventually "display count,  min/max delay, elapsed, avg time" do
      skip "not implemented"
    end
  end

  context "CONFIGURATION" do
    should_eventually "display configuration settings" do
      skip "not implemented"
    end
  end

  context "STATUS" do
    should_eventually "display normal T&L Status" do
      skip "not implemented"
    end
  end

  context "STARTUP" do
    should_eventually "have command line startup" do
      skip "not implemented"
    end
  end

end
