$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "json_api_client_mock/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "json_api_client_mock"
  s.version     = JsonApiClientMock::VERSION
  s.authors     = ["Jeff Ching"]
  s.email       = ["ching.jeff@gmail.com"]
  s.homepage    = "http://github.com/chingor13/json_api_client_mock"
  s.summary     = "Easily mock JsonApiClient queries"
  s.description = "Adds methods to JsonApiClient allowing you to easily mock test results"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "json_api_client", ">= 0.2.4"
  s.add_dependency "mocha"

  s.add_development_dependency "sqlite3"
end
