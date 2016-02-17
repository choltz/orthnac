module Services
  module Base
    # Internal: Extend the class with the class and instance level methods
    # defined in this file
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Public: Map all class-level call method calls to a cached copy of the
      # instance
      #
      # Returns: whatever the instance call results
      def call(*args, &block)
        @instance ||= self.new
        @instance.call *args, &block
      end
    end
  end
end
