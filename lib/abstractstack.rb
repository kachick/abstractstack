# Copyright (c) 2012 Kenichi Kamiya

require 'forwardable'
require_relative 'abstractstack/version'
require_relative 'abstractstack/exceptions'
require_relative 'abstractstack/subscriptable'
require_relative 'abstractstack/instance_methods'

# @example
#   class SimpleStack < AbstractStack; end
# @example
#   class LIFO < AbstractStack
#     include Enumerable
#
#     alias_method :each, :lifo_each
#     alias_method :reverse_each, :fifo_each
#     alias_method :first, :top
#     alias_method :last, :bottom
#   end
class AbstractStack
end

require_relative 'abstractstack/fifo'
require_relative 'abstractstack/lifo'