require 'active_model'

module ForkThis
  class BaseModel
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    attr_reader   :errors

    def initialize(attributes = {})
      @attributes = attributes
      @attributes.each do |name, value|
        send("#{name}=", value)
      end
      @errors = ActiveModel::Errors.new(self)
    end

    def persisted?
      false
    end

    def inspect
      inspection = if @attributes
        @attributes.map{ |key, value| "#{key}: #{value}" }.join(", ")
      else
        "not initialized"
      end
      "#<#{self.class} #{inspection}>"
    end

  end
end
