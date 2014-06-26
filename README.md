# Streamable

Allows you to stream data through a set of functions:

```ruby
[1] pry(main)> stream 1, :Float
=> 1.0
[2] pry(main)> stream 1, :Float, :p, :Integer
1.0
=> 1
[3] pry(main)> stream 1, :Float, -> i { i * 5 }
=> 5.0
```

Multistream lets you do this with multiple sets of initial data:

```ruby
[4] pry(main)> multistream data: [1,2], methods:[->(a,b) { a * b }]
=> 2
```

## Installation

Add this line to your application's Gemfile:

    gem 'streamable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install streamable


## Contributing

1. Fork it ( http://github.com/baweaver/streamable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
