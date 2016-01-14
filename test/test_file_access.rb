require_relative 'test_helper'
require_relative '../stub_helpers'

class FileAccessTest < Minitest::Test

  context "DISK FILE ACCESS" do

    ###############
    setup do
      @m = Class.new do
        include StubHelpers
      end.new
      @test_file_directory = TestHelper.findTestFileDirectory+"/data"
      #puts "test_file_directory: #{@test_file_directory}"
    end

    teardown do
    end
    ###############

    # figure out the right name to use.
    context ">DISK FILE NAME" do
      should "get exact name for existing file" do
        s = @m.getDiskFileName(@test_file_directory, "/not_empty", "exists.json")
        assert_equal "#{@test_file_directory}/not_empty/exists.json", s, "existing file name"
      end

      should "get nil if no exact file and no default file" do
        s = @m.getDiskFileName(@test_file_directory, "/not_empty", "missing.json")
        assert_nil s, "no default file"
      end

      should "get name of default file if no exact file" do
        s = @m.getDiskFileName(@test_file_directory, "/subdir", "missing.json")
        assert_equal "#{@test_file_directory}/subdir/default.json", s, "use default file"
      end

      should_eventually "file extension is optional" do

      end
    end


    # For REST may have a subpath that should map to a file but still be able to be part of a path
    # for different queries
    context ">DISK DIRECTORY AND FILE SAME NAME" do
      should_eventually "get back file if name is at end of request" do
        s=@m.getDiskFileName(@test_file_directory, "/","maybedirectory")
      end

      should_eventually "get back sub file if a name is used as part of a path" do
      end
    #   should "get exact name for existing file" do
    #     s = @m.getDiskFileName(@test_file_directory, "/not_empty", "exists.json")
    #     assert_equal "#{@test_file_directory}/not_empty/exists.json", s, "existing file name"
    #   end
    #
    #   should "get nil if no exact file and no default file" do
    #     s = @m.getDiskFileName(@test_file_directory, "/not_empty", "missing.json")
    #     assert_nil s, "no default file"
    #   end
    #
    #   should "get name of default file if no exact file" do
    #     s = @m.getDiskFileName(@test_file_directory, "/subdir", "missing.json")
    #     assert_equal "#{@test_file_directory}/subdir/default.json", s, "use default file"
    #   end
    end

    # actually get the file
    context ">DISK FILE RETRIEVAL" do

      should "find existing file" do
        s = @m.getDiskFileName(@test_file_directory, "/not_empty", "exists.json")
        assert_equal "#{@test_file_directory}/not_empty/exists.json", s, "existing file"
        data = @m.getDiskFile(s)
        assert_match  '["not_empty/exists.json"]', data ,"existing file"
      end

      should "find default file" do
        s = @m.getDiskFileName(@test_file_directory, "/subdir", "missing.json")
        assert_equal "#{@test_file_directory}/subdir/default.json", s, "missing file"
        data = @m.getDiskFile(s)
        assert_match  '["subdir/default.json"]', data ,"default file"
      end

      should "halt if no exact or default file found" do
        s = @m.getDiskFileName(@test_file_directory, "/not_empty", "missing.json")
        assert_nil s, "no matching file"
        data = @m.getDiskFile(s)
        assert_nil data ,"no exact or default file"
      end

      # should "get nil if no exact file and no default file" do
      #   s = @m.getDiskFileName("./test-files/data", "/not_empty", "missing.json")
      #   assert_nil s, "no default file"
      # end
      #
      # should "get name of default file if no exact file" do
      #   s = @m.getDiskFileName("./test-files/data", "/subdir", "missing.json")
      #   assert_equal "./test-files/data/subdir/default.json", s, "no default file"
      # end
    end

  end

end
