require 'test_helper'

class Notion::ApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Notion::API::VERSION
  end

  def setup
    @api = Notion::API.connect(api_token: "bogus")
  end

  def test_echo
    expected_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "bogus",
    }
    fake_response = {}
    request = stub_request(:get, "https://analyze.jamacloud.com/api/v1/echo")
      .with(:headers => expected_headers)
      .to_return(:status => 200, :body => fake_response.to_json, :headers => {"Content-Type" => "application/json"})

    assert_equal fake_response, @api.echo
    assert_requested request
  end
end
