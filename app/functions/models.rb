module Functions
  class Models < FunctionGroup
    compose :find_openstruct_by, -> { find_by >> to_openstruct }
    compose :find_attributes_by, -> { find_by >> to_attributes }

    def self.find_by
      Function.new do |model, *args|
        model.to_s.capitalize.constantize.find_by(*args)
      end
    end

    def self.to_attributes
      Function.new do |model|
        model.try(:attributes)
      end
    end

    def self.to_openstruct
      Function.new do |model|
        OpenStruct.new model.attributes if !model.nil?
      end
    end
  end
end
