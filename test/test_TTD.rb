require_relative 'test_helper'
require_relative '../stub_helpers'

class TTDTest < Minitest::Test

  context "STATS" do
    should_eventually "display count, min/max delay, elapsed, avg time"
  end

  context "CONFIGURATION" do
    should_eventually "display configuration settings"
  end

  context "STATUS" do
    should_eventually "display normal T&L Status urls"
  end

end
