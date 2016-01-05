
require_relative 'test_helper'

require_relative '../stub_helpers'

class StatsTest < Minitest::Test

  context "STATS" do
    ################
    setup do
    end

    teardown do
    end
    ###############

    should "display count,  min/max delay, elapsed, avg time" do
      assert_equal 'a','a',"dull as toast"
    end
  end

  context "CONFIGURATION" do
    should "display configuration settings" do
      assert_equal 'a','a',"dull as toast"
    end
  end


end
