module Functions
  class Util < FunctionGroup
    class << self
      # Public: insert a debugger into a composition
      def debugger
        Function.new do |arg|
          Byebug.debugger
          arg
        end
      end

      # Public: Apply the given block to each element in an array
      def map(&block)
        Function.new do |array|
          array.map(&block)
        end
      end
    end
  end
end
