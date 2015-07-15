# JsonApiClientMock [![Build Status](https://travis-ci.org/chingor13/json_api_client_mock.png)](https://travis-ci.org/chingor13/json_api_client_mock)

This gem allows you to easily test [json_api_client](json_api_client) gem.

## Usage

In your `Gemfile`:

```
group :test do
  gem 'json_api_client_mock', '~> 0'
end
```

To set a global mock for `MyResource`:

```
MyResource.set_test_results([
  {foo: 'bar', qwer: 'asdf'},
  {foo: 'wat', qwer: 'zxcv'}
])

MyResource.all
=> [<#MyResource foo:'bar', qwer:'asdf'>, <#MyResource foo:'wat', qwer:'zxcv'>]

MyResource.where(condition1: 'value', condition2: 'value2').all
=> [<#MyResource foo:'bar', qwer:'asdf'>, <#MyResource foo:'wat', qwer:'zxcv'>]
```

To set a targeted mock for `MyResource`:

```
MyResource.set_test_results([
  {foo: 'asdf', 'qwer': 'bar'}
], {
  condition1: 'value1',
  condition2: 'value2',
})

MyResource.where(condition1: 'value1', condition2: 'value2').all
=> [<#MyResource foo:'asdf', qwer:'bar'>]
```
To set the response meta for `MyResource`:

```
MyResource.set_test_results([
  {foo: 'asdf', 'qwer': 'bar'}
], {
  condition1: 'value1',
  condition2: 'value2',
}, {
  meta_attribute: 1000
})

response = MyResource.where(condition1: 'value1', condition2: 'value2').all
=> [<#MyResource foo:'asdf', qwer:'bar'>]
puts response.meta
=> { :meta_attribute => 1000 }
```

# condition order should not matter
MyResource.where(condition2: 'value2', condition1: 'value1').all
=> [<#MyResource foo:'asdf', qwer:'bar'>]
```

### Mock Priority

If you set multiple mocks that match the same query, the last matching result set should be returned. If no targetted match is found, we will return the untargeted result set you've specified (if it exists). If no mock is found, we will raise a `JsonApiClientMock::MissingMock` exception.

## Contributing

Please fork and send me a pull request.

## License

This project rocks and uses MIT-LICENSE.

[json_api_client]: http://github.com/chingor13/json_api_client