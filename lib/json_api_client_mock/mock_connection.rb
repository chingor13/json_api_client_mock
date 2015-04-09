require 'ostruct'

module JsonApiClientMock
  class MockConnection
    class_attribute :mocks
    self.mocks = {}

    # ignored
    def initialize(*attrs); end
    def use(*attrs); end
    def delete(*attrs); end

    def execute(query)
      if results = find_test_results(query)
        OpenStruct.new(:body => {
          query.klass.table_name => results[:results]
        })
      else
        raise MissingMock, missing_message(query)
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

    def class_mocks(query)
      self.class.mocks.fetch(query.klass.name, [])
    end

    def find_test_results(query)
      class_mocks(query).detect { |mock| mock[:conditions] == query.params } ||
        class_mocks(query).detect { |mock| mock[:conditions] && (mock[:conditions][:path] == query.path) } ||
          class_mocks(query).detect { |mock| mock[:conditions].nil? }
    end

    def missing_message(query)
      ["no test results set for #{query.klass.name} with conditions: #{query.params.pretty_inspect} or for request path #{query.path}",
        "mocks conditions available: #{class_mocks(query).map { |m| m[:conditions] }.pretty_inspect}"].join("\n\n")
    end
  end
end
