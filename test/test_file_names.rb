#require 'rubygems'
require 'minitest'
require 'minitest/autorun'
require 'minitest/unit'
# require 'webmock/minitest'

#require_relative 'test_helper'
require_relative '../stub_helpers'


class TestFileNameGeneration < Minitest::Test

  include StubHelpers

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test


  ### test that the full file paths are generated.
  def test_gen_disk_existing_file
    m = Class.new do
      include StubHelpers
    end.new

    s = m.getDiskFileName("./test-files/data","/not_empty", "exists.json")
    puts "s: [#{s}]"
    assert_equal "./test-files/data/not_empty/exists.json",s,"existing file"
  end

  def test_gen_disk_no_default_file
    m = Class.new do
      include StubHelpers
    end.new

    s = m.getDiskFileName("./test-files/data","/not_empty", "missing.json")
    puts "s: [#{s}]"
    assert_nil s,"no default file"
  end

  def test_gen_disk_default_file
    m = Class.new do
      include StubHelpers
    end.new

    s = m.getDiskFileName("./test-files/data","/subdir", "missing.json")
    puts "s: [#{s}]"
    assert_equal "./test-files/data/subdir/default.json",s,"no default file"
  end

  #################### test generating list of possible stub files.

  ### test that the full file paths are generated.
  def test_generate_data_file_list_default
    location = 'https://howdy.there/mydirectory/'
    suffix = 'json'

    m = Class.new do
      include StubHelpers
    end.new

    files = m.generate_data_file_list location, [], suffix

    assert_equal 1, files.length, "get one default file"

    assert_match /^#{location}/, files[0], "starts with location"
    assert_match /#{suffix}$/, files[0], "starts with json"
    assert_match /default/, files[0], "contains default"
  end


  def test_generate_data_file_list_abba_dylan
    location = 'https://howdy.there/mydirectory/'
    suffix = 'json'

    m = Class.new do
      include StubHelpers
    end.new

    files = m.generate_data_file_list location, ['ABBA', 'DYLAN'], suffix
    assert_equal 3, files.length, "files: 2 from infix and 1 for default"

    # they all got the prefix and suffix
    files.each { |f| assert_match /^#{location}/, f, "starts with location" }
    files.each { |f| assert_match /#{suffix}$/, f, "ends with suffix" }

    # only one had default
    assert_match /default\./, files[-1], "contains default"
    files.slice(0..1).each { |f| refute_match /default/, f, "does not have default" }

    # one has ABBA but not dylan
    files.slice(0..1).each { |f| assert_match /ABBA\./, f, "does have ABBA" }
    files.slice(1..2).each { |f| refute_match /DYLAN/, f, "does not have DYLAN" }

    # last has dylan
    assert_match /DYLAN\./, files[0], "does have DLYAN"
  end


  ### code to assemble the list of possible names from the infix array.
  def test_empty_array
    m = Class.new do
      include StubHelpers
    end.new

    s = m.all_infix_strings([])
    assert_equal 'default.', s[0], "get 'default' if nothing else"
    assert_equal 1, s.length, "null array includes default"
  end

  def test_single_value_array
    m = Class.new do
      include StubHelpers
    end.new
    s = m.all_infix_strings(['ABBA'])
    assert_equal 2, s.length, "single value comes back (and default)"
    assert_equal 'default.', s[0], "get back the single value."
    assert_equal 'ABBA.', s[1], "get back the single value."
  end

  def test_two_value_array
    m = Class.new do
      include StubHelpers
    end.new
    s = m.all_infix_strings(['ABBA', 'DYLAN'])
    #puts "s: <#{s}>"
    assert_equal 3, s.length, "two specific values back"
    assert_equal 'default.', s[0], "get back the default value."
    assert_equal 'ABBA.', s[1], "get back the first appended."
    assert_equal 'ABBA.DYLAN.', s[2], "get back the values appended."
  end


end
