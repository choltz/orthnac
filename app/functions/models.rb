module Functions
  class Models < FunctionGroup
    compose :find_openstruct_by, -> (model, field) { find_by(model, field) >> to_openstruct }
    compose :find_attributes_by, -> (model, field) { find_by(model, field) >> to_attributes }

    # Public: Return a function that finds an account with the given arguments
    #
    # Returns a function
    #   model: symbol of the model to query
    #   args   query arguments
    def self.find_by(model, field)
      Function.new do |value|
        model.to_s.capitalize.constantize.find_by(field.to_s, value)
      end
    end

    # Public: converts the given model to a hash of attributes
    #
    # Returns a function
    #   model: model to process
    def self.to_attributes
      Function.new do |model|
        model.try(:attributes)
      end
    end

    # Public: conerts the given model to an open struct object
    #
    # Returns a function
    #   model: model to process
    def self.to_openstruct
      Function.new do |model|
        OpenStruct.new model.attributes if !model.nil?
      end
    end
  end
end
