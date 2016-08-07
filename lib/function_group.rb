class FunctionGroup
  def self.compose(name, composition)
    (class << self; self; end).class_eval do
      define_method name do
        composition.call
      end
    end
  end
end
