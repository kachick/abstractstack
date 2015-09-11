abstractstack
===============

[![Build Status](https://secure.travis-ci.org/kachick/abstractstack.png)](http://travis-ci.org/kachick/abstractstack)
[![Gem Version](https://badge.fury.io/rb/abstractstack.png)](http://badge.fury.io/rb/abstractstack)
[![Dependency Status](https://gemnasium.com/kachick/abstractstack.svg)](https://gemnasium.com/kachick/abstractstack)

Description
-----------

Easy to get stack APIs

Features
--------

### In AbstractStack

* push, <<
* pop
* bottom
* top, peek
* length, size
* empty?
* fifo_each, lilo_each
* lifo_each, filo_each

### Only at FIFO(LILO), LIFO(FILO)

* [], at
* each
* reverse_each

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
stack = AbstractStack::LIFO.new
stack << 1 << 7
stack.map { |v| v * 2 }  #=> [14, 2]
stack[0]                 #=> 7
stack[-1]                #=> 1
```

Requirements
-------------

* Ruby - [2.0 or later](http://travis-ci.org/#!/kachick/abstractstack)

Install
-------

```shell
$ gem install abstractstack
```

Link
----

* [code](https://github.com/kachick/abstractstack)
* [API](http://www.rubydoc.info/github/kachick/abstractstack)
* [issues](https://github.com/kachick/abstractstack/issues)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
