# LogInFile

To write easily log messages in an output file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_in_file'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install log_in_file

## Usage

~~~ruby
require 'log_in_file'

logif("This message will be always written in a file.")

Logif.severity_level = Logif::WARN|Logif::ERROR

# This message will not be written
logif(Logif::INFO, "Message written only for info")

# This message will be written
logif(Logif::WARN, "Be carefull!")

~~~

### Message with data (*template message*)

~~~ruby

msg = "This is a %{how} message."
logif( msg, **{ data: { how: 'right' } } )

# => write "This is a right message." in the log file.
~~~

To open the log file (to read it):

~~~ruby
Logif.open

# or:

Logif.start
~~~

To remove the log file:

~~~ruby
Logif.remove_log
~~~


### Severity levels

~~~
Logif::NOTICE
Logif::INFO
Logif::WARN
Logif::ERROR
~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/log_in_file.

