module Invoicexpress
  module Utils
    class << self
      def singularize(str)
        str.gsub(/es$/, '').gsub(/s$/, '')
      end

      def constantize(camel_cased_word)
        names = camel_cased_word.split('::')
        names.shift if names.empty? || names.first.empty?

        constant = Object
        names.each do |name|
          constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
        end
        constant
      end

      def constantize_resource_name(resource_name)
        class_name = Utils.singularize(resource_name.capitalize)
        define_lightweight_class(class_name) unless Invoicexpress::Model.const_defined?(class_name, false)
        namespaced_class_name = "Invoicexpress::Model::#{class_name}"
        constantize namespaced_class_name
      end

      def constantize_singular_resource_name(resource_name)
        class_name = resource_name.split('_').map(&:capitalize).join
        define_lightweight_class(class_name) unless Invoicexpress::Model.const_defined?(class_name, false)
        namespaced_class_name = "Invoicexpress::Model::#{class_name}"
        constantize namespaced_class_name
      end

      def define_lightweight_class(class_name)
        raise Exception.new("Can't find #{class_name}")
      end
    end
  end
end
