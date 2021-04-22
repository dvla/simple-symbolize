# Symbolize

Symbolize takes a string and transforms it into a symbol. Why? Because working with symbols in Ruby makes for a 
good time.

Wait, doesn't String already have a `to_sym` method?

Correct! However, this gem takes it one step further by transforming special characters and whitespace to give you a 
super easy to work with symbol

It works by transforming special characters in a String like `'!'` into underscores and removing whitespace.

#### Example

```ruby
# to_sym
'hello world!'.to_sym # => :"hello world!"

# Symbolize gem
'hello world!'.symbolize # => :hello_world
```

testing drone test
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dvla-symbolize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dvla-symbolize

## Usage

There are two ways to symbolize your String.

### Call the symbolize method and pass it your String
```ruby
require 'symbolize'

symbolize('hello world!') # => :hello_world
```

### Call the symbolize method on your String object
```ruby
require 'symbolize'

'hello world!'.symbolize # => :hello_world
```

## Configuration

Something not underscored or removed? Or even something underscored/removed that you didn't want transformed? 

No sweat, you can configure this gem to underscore and remove to your hearts content!

```ruby
Symbolize.translate do |trans|
  trans.to_underscore('!')
  trans.to_remove(' ')
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dvla-symbolize.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
