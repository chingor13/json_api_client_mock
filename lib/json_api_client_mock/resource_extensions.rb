module JsonApiClientMock
  module ResourceExtensions
    extend ActiveSupport::Concern

    included do
      class_attribute :test_mocks
      self.test_mocks = []
    end

    module ClassMethods
      def set_test_results(results, parameters = {})
        self.test_mocks += {:results => results, :params => parameters}
        true
      end

      def clear_test_results
        self.test_mocks = []
      end

      def find(conditions)
        self.test_mocks.detect{|mock| mock[:params] == conditions} || raise MissingMock, "no test results set for #{self.name} with conditions: #{conditions.inspect}"
      end
    end
  end
end