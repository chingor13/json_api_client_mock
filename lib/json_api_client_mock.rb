require 'json_api_client'

module JsonApiClientMock
  autoload :ResourceExtensions, "json_api_client/resource_extensions"
end

JsonApiClient::Resource.send(:include, JsonApiClientMock::ResourceExtensions)
