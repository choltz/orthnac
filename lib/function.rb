# Public: function object that extends procs to include composition and adds
# some syntactical sugar.
class Function < Proc
  def initialize(identifier=nil)
    @identifier = identifier
  end

  # Public: override pipe operator to compose functions
  def | (function)
    self.class.compose(self, function)
  end

  # Public: functional composition. Incoming and outgoing values must have the
  # same arity.
  #
  # functions - list of function objects to compose
  #
  # Returns a compositional function
  def self.compose(*functions)
    self.new do |*args|
      functions.reduce(args) do |result, function|
        function.call(*result)
      end
    end
  end
end
