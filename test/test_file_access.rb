
require_relative 'test_helper'
require_relative '../stub_helpers'

class FileAccessTest < Minitest::Test

  context "DISK FILE ACCESS" do

    ###############
    setup do
      @m = Class.new do
        include StubHelpers
      end.new
    end

    teardown do
    end
    ###############

    should "test_gen_disk_existing_file" do
      s = @m.getDiskFileName("./test-files/data", "/not_empty", "exists.json")
      assert_equal "./test-files/data/not_empty/exists.json", s, "existing file"
    end

    should "test_gen_disk_no_default_file" do
      s = @m.getDiskFileName("./test-files/data", "/not_empty", "missing.json")
      assert_nil s, "no default file"
    end

    should "test_gen_disk_default_file" do
      s = @m.getDiskFileName("./test-files/data", "/subdir", "missing.json")
      assert_equal "./test-files/data/subdir/default.json", s, "no default file"
    end

  end

end
