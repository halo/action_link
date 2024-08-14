# ActionLink

ActionLink is a Ruby gem that provides intuitive ViewComponents for CRUD resource link actions in Rails. It simplifies the process of creating common action links (show, edit, delete, etc.) with associated icons.

## Usage

Here's an example of how to use the `ActionLink` gem in a Rails view:

```ruby
# In Rails view
= render ActionLink::Show.new(url: [:admin, @post], current_user: current_user)
```

## More Usage Examples

Here are some more examples of how to use the `ActionLink` gem in a Rails view:

```ruby
# In Rails view
= render ActionLink::Edit.new(url: [:edit, @post], current_user: current_user)
= render ActionLink::Destroy.new(url: [:destroy, @post], current_user: current_user)
= render ActionLink::New.new(url: [:new, @post], current_user: current_user)
```

## Installation

To install the `ActionLink` gem, add it to your application's Gemfile and run `bundle install`:

```ruby
gem 'action_link'
```

Alternatively, you can install the gem manually by running:

```sh
gem install action_link
```

## Development

To contribute to the development of the `ActionLink` gem, follow these steps:

1. Fork the repository on GitHub.
2. Clone your forked repository to your local machine.
3. Install the gem's dependencies by running `bin/setup`.
4. Run the tests to ensure everything is working correctly: `rake test`.
5. Make your changes and add tests for your changes.
6. Commit your changes and push them to your forked repository.
7. Create a pull request on GitHub with a description of your changes.

## License

The `ActionLink` gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The icons used in this gem are taken from the incredible [iconmonstr](https://iconmonstr.com/license/).
