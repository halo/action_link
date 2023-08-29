# ActionLink

Intuitive ViewComponents for CRUD resource link actions in Rails.

## Usage

```ruby
# In Rails view
= render ActionLink::Show.new(url: [:admin, @post], current_user:)
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add action_link

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install action_link

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/halo/action_link.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The icons are taken from the incredible [iconmonstr](https://iconmonstr.com/license/).
