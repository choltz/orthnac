module Services
  module Base
    # Internal: Extend the class with the class and instance level methods
    # defined in this file
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Public: Validate the presence of a key in an options hash. Raise and
    # error if no instance is found
    #
    #   value - value to evaluate
    #
    # Returns: Null. If an exception is raised, then nothing is returned
    def validates_presence_of(value)
      raise Exception.new("#{self.class.name}: expected :#{value} to not be blank") value.blank?
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
