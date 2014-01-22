module JsonApiClientMock
  module ResourceExtensions
    extend ActiveSupport::Concern

    module ClassMethods
      def connection
        MockConnection.instance
      end

      def set_test_results(results, conditions = nil)
        connection.set_test_results(self, results, conditions)
      end

      def clear_test_results
        connection.clear_test_results
      end

    end
  end
end