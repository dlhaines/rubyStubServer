require_relative 'test_helper'
require_relative '../stub_helpers'

class FileNameGenerationTest < Minitest::Test

  context "FILE NAME GENERATION" do

    #################
    setup do
      @m = Class.new do
        include StubHelpers
      end.new

      @location = 'https://howdy.there/mydirectory/'
      @suffix = 'json'

    end

    teardown do

    end
    #################

    ######## test generation of versions of appended names
    context ">NAME VARIANTS" do
      should "name array passed single value adds default file" do

        s = @m.all_infix_strings(['ABBA'])
        assert_equal 2, s.length, "single value comes back (and default)"
        assert_equal 'default.', s[0], "get back the single value."
        assert_equal 'ABBA.', s[1], "get back the single value."

      end

      should "get default file if no names supplied" do
        s = @m.all_infix_strings([])
        assert_equal 'default.', s[0], "get 'default' if nothing else"
        assert_equal 1, s.length, "null array includes default"
      end

      should "get three names from two names" do
        s = @m.all_infix_strings(['ABBA', 'DYLAN'])
        assert_equal 3, s.length, "two specific values back"
        assert_equal 'default.', s[0], "get back the default value."
        assert_equal 'ABBA.', s[1], "get back the first appended."
        assert_equal 'ABBA.DYLAN.', s[2], "get back the values appended."
      end
    end


    # generate proper files names
    context ">PROPER FILE NAMES" do

      should "default file has full path" do

        files = @m.generate_data_file_list @location, [], @suffix

        assert_equal 1, files.length, "get one default file"
        assert_match /^#{@location}/, files[0], "starts with location"
        assert_match /#{@suffix}$/, files[0], "ends with json"
        assert_match /default/, files[0], "contains default"
      end

      should "generate 3 separate files including default" do
        files = @m.generate_data_file_list @location, ['ABBA', 'DYLAN'], @suffix
        assert_equal 3, files.length, "files: 2 from infix and 1 for default"

        # they all got the prefix and suffix
        files.each { |f| assert_match /^#{@location}/, f, "starts with location" }
        files.each { |f| assert_match /#{@suffix}$/, f, "ends with suffix" }

        # only one had default
        assert_match /default\./, files[-1], "contains default"
        files.slice(0..1).each { |f| refute_match /default/, f, "does not have default" }

        # one has ABBA but not dylan
        files.slice(0..1).each { |f| assert_match /ABBA\./, f, "does have ABBA" }
        files.slice(1..2).each { |f| refute_match /DYLAN/, f, "does not have DYLAN" }

        # last has dylan
        assert_match /DYLAN\./, files[0], "does have DLYAN"
      end
    end
  end

end
