Bundler.require(:default, :test)

require 'minitest/autorun'
require 'pp'

# test classes

class BaseResource < JsonApiClient::Resource
  self.site = "http://test.host/api/1"
end

class BarResource < BaseResource
end

class FooResource < BaseResource
end

class BarExtendedResource < BarResource
end