# Notion::API

A Ruby client for submitting data to [Notion](http://usenotion.com).

![CircleCI](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser.svg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notion-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notion-api

## Usage

```
client = Notion::API.connect(api_token: YOUR_API_TOKEN_HERE)
client.report(
  ingredient_id: INGREDIENT_ID_FROM_DASHBOARD,
  date: "2016-10-28",
  value: 42.24
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/notion-data/notion-api.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
