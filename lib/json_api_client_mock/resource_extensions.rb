module JsonApiClientMock
  module ResourceExtensions
    extend ActiveSupport::Concern

    included do
      self.connection_class = MockConnection
    end

    module ClassMethods
      def set_test_results(results, conditions = nil)
        connection.set_test_results(self, results, conditions)
      end

      def clear_test_results
        connection.clear_test_results
      end

    end
  end
end