# Instant2FA

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instant2fa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instant2fa

## Usage

```ruby
Instant2FA.configure do |config|
  config.access_key = 'YOUR_ACCESS_KEY'
  config.access_secret = 'YOUR_ACCESS_SECRET'
end

distinct_id = "A_UNIQUE_ID_FOR_A_USER"

hosted_page_url = Instant2FA.create_settings(distinct_id)
hosted_page_url = Instant2FA.create_verification(distinct_id)
verification_succeeded = Instant2FA.confirm_verification(distinct_id, token)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clef/instant2fa-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

