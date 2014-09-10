module JsonApiClientMock
  module ResourceExtensions
    extend ActiveSupport::Concern

    included do
      class_attribute :original_connection_class
      self.original_connection_class = self.connection_class
      self.disable_net_connect!
    end

    module ClassMethods
      def set_test_results(results, conditions = nil)
        connection.set_test_results(self, results, conditions)
      end

      def clear_test_results
        connection.clear_test_results
      end

      def allow_net_connect!
        self.connection_class = self.original_connection_class
      end

      def disable_net_connect!
        self.connection_class = MockConnection
      end
    end
  end
end
