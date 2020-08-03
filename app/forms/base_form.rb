class BaseForm
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  extend ActiveModel::Naming

  def self.attribute attr_name, attr_type, options={}
    attr_accessor "#{attr_name}"
    attr_type = attr_type.to_s.camelize

    define_method "#{attr_name}=" do |val|
      typecasted_val = nil
      if options[:array] == true
        val = [val] unless val.is_a?(Array)
        typecasted_val = val.map{|v|
          typecast_val(attr_type, v)
        }

        typecasted_val = typecasted_val.compact if options[:compact] == true
      else
        typecasted_val = typecast_val(attr_type, val)
      end
      instance_variable_set("@#{attr_name}", typecasted_val)
    end

    define_method "#{attr_name}" do
      val = instance_variable_get("@#{attr_name}")
      val = [] if options[:array] == true and val.nil?
      val
    end
  end

  def typecast_val attr_type, val
    val.nil? ? nil : ActiveRecord::Type.const_get(attr_type).new.send(:cast_value, val)
  end
end
