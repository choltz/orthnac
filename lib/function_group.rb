class FunctionGroup
  def self.compose(name, composition)
    (class << self; self; end).class_eval do
      define_method name do |*args|
        composition.call(*args)
      end
    end
  end
end
