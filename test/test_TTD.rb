require_relative 'test_helper'
require_relative '../stub_helpers'

class TTDTest < Minitest::Test

    context "STATUS" do
    should_eventually "display normal T&L Status urls"
  end

end
