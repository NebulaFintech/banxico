# Banxico

Basic Banxico client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'banxico', git: 'https://github.com/NebulaFintech/banxico.git'
```

And then execute:

    $ bundle

## Usage

```
exchange_rate = Banxico::Client.series({currency: :usd}).first
exchange_rate.currency # mxn
exchange_rate.date # Date.today
exchange_rate.value # Float
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/NebulaFintech/banxico. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Banxico project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/NebulaFintech/banxico/blob/master/CODE_OF_CONDUCT.md).

## Credits

This gem was created based on https://github.com/Maquech/MX-Banxico.