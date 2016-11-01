module Functions
  class Arrays
    class << self
      # Public: Reverse the given array
      def reverse
        Function.new do |array|
          array.reverse
        end
      end
    end
  end
end
