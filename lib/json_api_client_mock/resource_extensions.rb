module JsonApiClientMock
  module ResourceExtensions
    extend ActiveSupport::Concern

    included do
      class_attribute :original_connection_class, :original_connection_object
      self.disable_net_connect!
    end

    module ClassMethods
      def set_test_results(results, conditions = nil, meta = {})
        connection.set_test_results(self, results, conditions, meta)
      end

      def clear_test_results
        connection.clear_test_results
      end

      def allow_net_connect!
        self.connection_class = self.original_connection_class
        self.connection_object = self.original_connection_object
      end

      def disable_net_connect!
        self.original_connection_class = self.connection_class
        self.original_connection_object = self.connection_object
        self.connection_class = MockConnection
        self.connection_object = nil
      end
    end
  end
end
