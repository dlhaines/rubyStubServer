require_relative 'test_helper'
require 'rack/test'
require_relative '../stubToDisk'

class AppServerTest < Minitest::Test

  include Rack::Test::Methods

  def app
    ENV['DATA_DIR'] = TestHelper.findTestFileDirectory+"/data"
    # Must return the application object
    App.new()
  end

  context "APP SERVER" do

    #################
    setup do
    end

    teardown do
    end
    #################

    ######## test generation of versions of appended names
    context ">GET FILES" do

      context ">TOP LEVEL" do
        should "top level (directory) should return 404" do
          get '/'

          assert_equal 404, last_response.status, "find top level"
        end

      end

      context ">NESTED 1 LEVEL" do
        should "return existing file" do
          get "/not_empty/exists.json"

          assert_equal 200, last_response.status, "find existing file"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["not_empty/exists.json"]', last_response.body.chomp, "has expected contents"
        end

        should "return default file" do
          get "/subdir/get_default_file_not_exact_file.json"

          assert_equal 200, last_response.status, "return a default file"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/default.json"]', last_response.body.chomp, "has expected contents"
        end

        should "missing file with no default returns 404" do
          get "/empty/nothing_here.json"

          assert_equal 404, last_response.status, "return 404 for missing file"
        end
      end

      context ">NESTED 2 LEVELS" do

        should "get exact file 2 directories deep" do
          get "/subdir/subdir2/exists.json"

          assert_equal 200, last_response.status, "return exact file"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/subdir2/exists.json"]', last_response.body.chomp, "has expected contents"
        end

        should "get default file 2 directories deep" do
          get "/subdir/subdir2/exists.json"

          assert_equal 200, last_response.status, "return exact file"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/subdir2/exists.json"]', last_response.body.chomp, "has expected contents"
        end

        should "get default file 2 directories deep no extension" do
          get "/subdir/subdir2/exists"

          assert_equal 200, last_response.status, "return exact file"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/subdir2/exists"]', last_response.body.chomp, "has expected contents"
        end

      end

      context ">HAVE QUERY PARAMETERS" do
        should "get file ignoring query parameters" do
          get "/subdir/subdir2/exists.json?IGNORE=ME"

          assert_equal 200, last_response.status, "return exact file with query parameters"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/subdir2/exists.json"]', last_response.body.chomp, "has expected contents"
        end
      end

      context ">HAVE QUERY PARAMETERS NO EXTENSION" do
        should "get file ignoring query parameters" do
          get "/subdir/subdir2/exists.json?IGNORE=ME"

          assert_equal 200, last_response.status, "return exact file with query parameters"
          refute_nil last_response.body, "body exists"
          refute_empty last_response.body, "existing file has contents"
          assert_equal '["subdir/subdir2/exists.json"]', last_response.body.chomp, "has expected contents"
        end
      end

    end

  end

end
