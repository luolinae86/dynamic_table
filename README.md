# DynamicTable
DynamicTable create model table default by Date.today

Suppose:
- Rails  model is Log
- Date.today = "Tue, 11 Jul 2017"

Log.create_table  will create table "logs_170711"

Log.create_table(Date.today - 1.days) will create table "logs_170710"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynamic_table'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamic_table

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dynamic_table.
