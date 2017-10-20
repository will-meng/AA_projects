class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      ivar_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(ivar_name) }

      define_method("#{name}=") do |value|
        instance_variable_set(ivar_name, value)
      end

    end
  end
end
