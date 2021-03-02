# DCS-gRPC ruby client

A ruby client for interacting with the gRPC server for the DCS-gRPC project. An attempt to implement an RPC interface
for the Digital Combat Simulator game by Eagle Dynamics


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dcs-grpc'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dcs-grpc

## Usage

Instantiate a new client with `Dcs::Grpc::Client.new` and pass in host and port if desired. See documentation for
more details. 

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DCS-gRPC/ruby-client


## License

The gem is available as open source under the terms of the [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.html).
