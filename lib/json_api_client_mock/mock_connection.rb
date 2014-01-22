require 'ostruct'

module JsonApiClientMock
  class MockConnection
    def self.instance
      @instance ||= self.new
    end

    def initialize
      # ignored
      @mocks = {}
    end

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
      @mocks[klass.name] ||= []
      @mocks[klass.name].unshift({results: results, conditions: conditions})
    end

    def clear_test_results
      @mocks = {}
    end

    protected

    def find_test_results(query)
      class_mocks = @mocks.fetch(query.klass.name, [])
      class_mocks.detect{|mock| mock[:conditions] == query.params} ||
        class_mocks.detect{|mock| mock[:conditions].nil?}
    end
  end
end