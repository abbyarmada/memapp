module ActiveRecord::Validations::ClassMethods
  def validates_associated(*attr_names)
    configuration = { :on => :save }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      (value.is_a?(Array) ? value : [value]).collect do |r|
        unless r.nil? || r.valid?
          r.errors.each_full do |msg|
            record.errors.add(:base, msg, :default => configuration[:message], :value => value)
          end
        end
      end
    end
  end
end