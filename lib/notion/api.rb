require "notion/api/version"
require 'excon'
require 'json'

module Notion; end

module Notion::API

  def self.connect(**args)
    Client.new(**args)
  end

  class Client
    DEFAULT_ROOT = "https://app.usenotion.com".freeze
    URL_TEMPLATE = "/api/%{version}/%{action}".freeze
    DEFAULT_VERSION = "v1"

    def initialize(api_token:, root: DEFAULT_ROOT, client: Excon)
      @client = client.new(
        root,
        headers: {
          "Authorization" => api_token,
          "Accept" => "application/json",
          "Content-Type" => "application/json",
          "User-Agent" => "notion-api/#{Notion::API::VERSION} #{client.name}/#{client::VERSION} Ruby/#{RUBY_VERSION}",
        }
      )
    end

    # /api/v1/echo
    #
    # Makes a generic test request to verify that the client is configured correctly.
    #
    # @returns [Hash]
    def echo
      get url("echo")
    end

    # /api/v1/report
    #
    # Report data for an existing ingredient (+ingredient_id+).
    #
    # @param ingredient_id [String]
    # @param value [Numeric]
    # @param date [String] A date string in the format "YYYY-MM-DD"
    #
    # @returns [Hash]
    def report(ingredient_id:, value:, date:)
      post url("report"), body(ingredient_id: ingredient_id, value: value, date: date)
    end

    # /api/v1/ingredient
    #
    # Create and report data for a new ingredient.
    #
    # @param name [String]
    # @param reports [Array<Hash>] An array of hashes with the keys +value+ and +date+,
    #   as with #report.
    def create_ingredient(name, reports: [])
      post url("ingredient"), body(name: name, reports: reports)
    end

    private

    def url(action, version: DEFAULT_VERSION)
      URL_TEMPLATE % {
        version: version,
        action: action
      }
    end

    def get(url)
      response @client.get(path: url)
    end

    def post(url, body)
      response @client.post(path: url, body: body)
    end

    def response(response)
      JSON.parse(response.body)
    end

    def body(params)
      JSON.generate(params)
    end

  end

end
