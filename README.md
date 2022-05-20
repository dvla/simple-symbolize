# SimpleSymbolize

SimpleSymbolize takes a string and transforms it into a symbol. Why? Because working with symbols in Ruby makes for a 
good time.

Wait, doesn't String already have a `to_sym` method?

Correct! However, this gem takes it one step further by transforming special characters and whitespace to give you a 
simple easy to work with Symbol.

It works by removing special characters in a String like `'!'` and underscoring any whitespace.

#### Example

```ruby
# to_sym
'hello world!'.to_sym # => :"hello world!"

# Symbolize gem
'hello world!'.symbolize # => :hello_world
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_symbolize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simple_symbolize

## Usage

There are two ways to symbolize your String.

### Call the symbolize method and pass it your String

```ruby
require 'simple_symbolize'

SimpleSymbolize.symbolize('hello world!') # => :hello_world
```

### Call the symbolize method on your String object

```ruby
require 'simple_symbolize'

'hello world!'.symbolize # => :hello_world
```

## Configuration

Something not underscored or removed? Or even something underscored/removed that you didn't want transformed? 

No sweat, you can configure this gem to underscore and remove to your hearts content!

```ruby
SimpleSymbolize.translate do |trans|
  trans.to_underscore('!')
  trans.to_remove(' ')
  trans.to_omit('@')
end
```

## Updates!

V1.1: SimpleSymbolize has got new friends!

Introducing `elementize` and `camelize`.

### Elementize

Sometimes you just want a simple String obj without all the fuss. Elementize takes your String obj, removes that fuss
and returns you a simple-to-use String.

#### Example

```ruby
elementize('hello world!') # => "hello_world"
```

### Camelize

Great for working with APIs that require fields in a JSON format. Camelize clears away the clutter and returns you 
a Symbolized object in camelCase.

#### Example

```ruby
camelize('hello world!') # => :helloWorld
```

[comment]: <> (## Contributing)

[comment]: <> (Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_symbolize.)


[comment]: <> (## License)

[comment]: <> (The gem is available as open source under the terms of the [MIT License]&#40;https://opensource.org/licenses/MIT&#41;.)
