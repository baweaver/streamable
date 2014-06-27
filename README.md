# Streamable

Allows you to stream data through a set of functions (Think point-free programming):

```ruby
# Same as Float(1)
[1] pry(main)> stream 1, :Float
=> 1.0
# Same as Integer(p(Float(1)))
[2] pry(main)> stream 1, :Float, :p, :Integer
1.0
=> 1
# Same as -> i { i * 5 }[Float(1)]
[3] pry(main)> stream 1, :Float, -> i { i * 5 }
=> 5.0
```

Multistream lets you do this with multiple sets of initial data:

```ruby
# Same as ->(a,b) { a * b }[1,2]
[4] pry(main)> multistream data: [1,2], methods:[->(a,b) { a * b }]
=> 2
```

## How does it work?

So what is this even doing? We've seen unix pipes:

```bash
echo 'foo' | grep f
```

We're essentially piping the output of one command to another. So let's go back to Ruby:

```ruby
stream(1, :Float)
```

This is passing the number one in as the first argument to the ``Kernel#Float`` method, or rather ``Float(1)``. What happens as we add more to it?

```ruby
stream(1, :Float, :p)
```

Now we're doing the same thing as before, and getting ``Float(1)``, and then sending that result into the ``Kernel#p`` function, such that we now effectively have ``p(Float(1))`` or ``p(1.0)`` if we evaluate the float.

So how does that happen in Ruby? With ``Enumerable#reduce``:

```ruby
n = 1
methods = [:Float, :p]

# We're reducing with the initial value of n, which is now in data inside the block
methods.reduce(n) { |data, method|
  # Now we call the method from the Kernel and pass it the data as the first argument.
  # As the value of data is set to the last return value of the block, this will fold over
  # the original value of data with the result of method(data) and will continue to cycle
  # through the remaining methods.
  Kernel.send(method, data)
} # Which gives us our value, and a nice faux pipe stream / point-free programming implementation.
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
