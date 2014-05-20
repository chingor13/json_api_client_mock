require 'ostruct'

module JsonApiClientMock
  class MockConnection
    class_attribute :mocks
    self.mocks = {}

    # ignored
    def initialize(*attrs); end

    def execute(query)
      if results = find_test_results(query)
        OpenStruct.new(:body => {
          query.klass.table_name => results[:results]
        })
      else
        raise MissingMock, "no test results set for #{query.klass.name} with conditions: #{query.params.inspect}"
      end      
    end

    def set_test_results(klass, results, conditions = nil)
      self.class.mocks[klass.name] ||= []
      self.class.mocks[klass.name].unshift({results: results, conditions: conditions})
    end

    def clear_test_results
      self.class.mocks = {}
    end

    protected

    def find_test_results(query)
      class_mocks = self.class.mocks.fetch(query.klass.name, [])
      class_mocks.detect{|mock| mock[:conditions] == query.params} ||
        class_mocks.detect{|mock| mock[:conditions].nil?}
    end
  end
end