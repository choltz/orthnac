# Public: function object that extends procs to include composition and adds
# some syntactical sugar.
class Function < Proc
  def initialize(identifier=nil)
    @identifier = identifier
  end

  # Public: override pipe operator to compose functions
  def >> (function)
    self.class.compose(self, function)
  end

  # Public: functional composition. Incoming and outgoing values must have the
  # same arity.
  #
  # functions - list of function objects to compose
  #
  # Returns a compositional function
  def self.compose(*functions)
    self.new do |args|
      functions.reduce(args) do |result, function|
        function.call(result)
      end
    end
  end

  # Public: curry the current function with multiple parameters into a sequence
  # of functions, each with a single parameter.
  # https://en.wikipedia.org/wiki/Currying
  #
  # function: function to curry
  #
  # Notes: ruby alreay provides a curry function, but it returns procs. This
  # curry function returns Function objects.
  #
  # Returns a function
  def curry
    curried = -> (*args) {
      if args.length >= parameters.length
        call(*args)
      else
        Function.new do |a|
          curried.call(*(args + [a]))
        end
      end
    }
  end

  def curry_right
    curried = -> (*args) {
      if args.length >= parameters.length
        call(*args)
      else
        Function.new do |a|
          curried.call(*([a] + args))
        end
      end
    }
  end
end
