abstractstack
===============

Description
-----------

A template of Stack classies.

Features
--------

### For basic operations.

* push, <<
* pop
* bottom
* top, peek 
* length, size
* empty?
* fifo_each, lilo_each
* lifo_each, filo_each

### Easy to get.

* [], at
* each
* reverse_each

### Others

* Pure Ruby :)

Usage
-----

### Setup

```ruby
require 'abstractstack'
```

### Simply

```ruby
class Stack < AbstractStack; end
stack = Stack.new
stack.push 1
stack << 7
stack.top    #=> 7
stack.bottom #=> 1
stack.peek   #=> 7
stack.pop    #=> 7
stack.pop    #=> 1
stack.pop    #=> Exception(UnderFlow)
```

### Size Limit

```ruby
stack = Stack.new 2
stack.limit          #=> 2
stack << 1 << 7
stack << 9           #=> Exception(Overflow)
```

### Enhanced Stack class

```ruby
class LIFO < AbstractStack
  include Enumerable
  include Subscriptable

  alias_method :each, :lifo_each
  alias_method :reverse_each, :fifo_each
  alias_method :first, :top
  alias_method :last, :bottom

  def at(pos)
    super pos, :top
  end
end

stack = LIFO.new
stack << 1 << 7
stack.map{|v|v * 2}  #=> [14, 2]
stack[0]             #=> 7
stack[-1]            #=> 1
```

Requirements
-------------

* Ruby - [1.9.2 or later](http://travis-ci.org/#!/kachick/abstractstack)

Build Status
-------------

[![Build Status](https://secure.travis-ci.org/kachick/abstractstack.png)](http://travis-ci.org/kachick/abstractstack)

Install
-------

```bash
$ gem install abstractstack
```

Link
----

* [Home](http://kachick.github.com/abstractstack/)
* [code](https://github.com/kachick/abstractstack)
* [API](http://kachick.github.com/abstractstack/yard/frames.html)
* [issues](https://github.com/kachick/abstractstack/issues)
* [CI](http://travis-ci.org/#!/kachick/abstractstack)
* [gem](https://rubygems.org/gems/abstractstack)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
