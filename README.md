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
'hello world!'.simple_symbolize # => :hello_world
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

There are three ways to use this gem.

### SimpleSymbolize

```ruby
require 'simple_symbolize'

SimpleSymbolize.symbolize('hello world!') # => :hello_world
```

Available methods:

| Method     | What does it do?                                                                                                                         |
|------------|------------------------------------------------------------------------------------------------------------------------------------------|
| symbolize  | Returns your object as a plain old symbol                                                                                                |
| elementize | Returns your object as a plain old String                                                                                                |
| camelize   | Returns your object as a plain old camelCase symbol                                                                                      |
| snakeize   | Returns your object as a plain old snake_case symbol (very similar to symbolize, only it does not respect the handle_camel_case setting) |                                                                                                        |

### Mixing into String

```ruby
require 'simple_symbolize'

String.include SimpleSymbolize::CoreExt::String

'hello world!'.simple_symbolize # => :hello_world
```

Available methods:

| Method     | What does it do?                                                                                                                         |
|------------|------------------------------------------------------------------------------------------------------------------------------------------|
| simple_symbolize  | Returns your object as a plain old symbol                                                                                                |
| simple_elementize | Returns your object as a plain old String                                                                                                |
| simple_camelize   | Returns your object as a plain old camelCase symbol                                                                                      |
| simple_snakeize   | Returns your object as a plain old snake_case symbol (very similar to symbolize, only it does not respect the handle_camel_case setting) |                                                                                                        |

### Mixing into Symbol

```ruby
require 'simple_symbolize'

Symbol.include SimpleSymbolize::CoreExt::Symbol

:hello_world!.simple_symbolize # => :hello_world
```

Available methods:

| Method     | What does it do?                                                                                                                         |
|------------|------------------------------------------------------------------------------------------------------------------------------------------|
| simple_symbolize  | Returns your object as a plain old symbol                                                                                                |
| simple_elementize | Returns your object as a plain old String                                                                                                |
| simple_camelize   | Returns your object as a plain old camelCase symbol                                                                                      |
| simple_snakeize   | Returns your object as a plain old snake_case symbol (very similar to symbolize, only it does not respect the handle_camel_case setting) |                                                                                                        |

## Configuration

Something not underscored or removed? Or even something underscored/removed that you didn't want transformed?

No sweat, you can configure this gem to underscore and remove to your hearts content!

```ruby
SimpleSymbolize.translate do |trans|
  trans.to_underscore = '!'
  trans.to_remove = ' '
  trans.to_omit = '@'
end
```

## Updates!

### V5

#### Dropped support for Ruby < 3.2

Ruby 3.1 reached EOL in 2024, as such this gem no longer supports versions older than 3.2.

#### Only deals with Strings and Symbols

In previous iterations, certain non String/Symbol objects would be handled `SimpleSymbolize.symbolze(true)` returned
`:true`.

To be consistent, SimpleSymbolize now only accepts String/Symbols, everything else will be returned.

#### Uppercase acronyms when camelizing

Sometimes you want certain phrases to be in uppercase when camelizing, SimpleSymbolize now supports this.

```ruby
SimpleSymbolize.translate { |t| t.camel_case_acronym = ['gb'] }

SimpleSymbolize.camelize('from gb') # => :fromGB (without setting the camel_case_acronym this would return :fromGb)
```

---

### V4.1

#### Symbol methods can now be Mixed in

SimpleSymbolize now supports mixing in the methods on the Symbol class, allowing you to call `simple_symbolize` directly
on a Symbol object.

```ruby
Symbol.include SimpleSymbolize::CoreExt::Symbol
:hello_world!.simple_symbolize # => :hello_world
```

---

### V4

#### String methods now need to be Mixed in

SimpleSymbolize is safe to use with other gems, particularly the popular ActiveSupport gem which SimpleSymbolize use to
share
certain methods names with.

You now need to deliberately mixin the methods on the String class:

```ruby
String.include SimpleSymbolize::CoreExt::String
```

To make them easier to spot, the method names on the String class have been prefixed with `simple_` to avoid confusion.

```ruby
'Hello World!'.simple_symbolize #=> :hello_world
'Hello World!'.simple_elementize #=> 'hello_world'
'Hello World!'.simple_camelize #=> :helloWorld
'Hello World!'.simple_snakeize #=> :hello_world
```

#### Introducing #snakeize

The `#snakeize` method will return your object in snake_case.
This is the default behaviour of the `#symbolize` method however `#snakeize` will always return thr Symbol in
snake_case.

---

### V3

#### String to_snake_case [DEPRECATED - replaced with `#simple_snakeize` in v4]

`#to_snake_case` extends the String class to return you your String object in snake_case format.

#### Handle camelCase with Symbolize

```ruby
SimpleSymbolize.symbolize('helloWorld!') # => :hello_world
```

This is the default behaviour and can be switched off by setting `#handle_camel_case` to `false`

```ruby
SimpleSymbolize.translate { |trans| trans.handle_camel_case = false }
```

#### Additional ways to configure SimpleSymbolize

Arrays are now supported when configuring the gem

```ruby
SimpleSymbolize.translate { |trans| trans.to_underscore = %w[!&*] }
```

---

### V2

SimpleSymbolize has got new friends!

Introducing `elementize` and `camelize`.

#### Elementize

Sometimes you just want a simple String obj without all the fuss. Elementize takes your String obj, removes that fuss
and returns you a simple-to-use String.

```ruby
SimpleSymbolize.elementize('hello world!') # => "hello_world"
```

#### Camelize

Great for working with APIs that require fields in a JSON format. Camelize clears away the clutter and returns you
a Symbolized object in camelCase.

[comment]: <> (## Contributing)

[comment]: <> (Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_symbolize.)


[comment]: <> (## License)

[comment]: <> (The gem is available as open source under the terms of the [MIT License]&#40;https://opensource.org/licenses/MIT&#41;.)
