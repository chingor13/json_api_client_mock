require 'json_api_client'

module JsonApiClientMock
  autoload :MissingMock, "json_api_client_mock/missing_mock"
  autoload :ResourceExtensions, "json_api_client_mock/resource_extensions"
end

JsonApiClient::Resource.send(:include, JsonApiClientMock::ResourceExtensions)
