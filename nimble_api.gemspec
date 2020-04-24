Gem::Specification.new do |s|
  s.name = %q{nimble_api_ak}
  s.version = "1.0.0"
  s.date = %q{2020-04-23}
  s.homepage  =  'https://github.com/Ankitkalia002/nimble-ak-api'
  s.authors       = ["Ankit Kalia"]
  s.email         = ["ankit.kalia002@gmail.com"]
  s.rdoc_options = ["README.md"]
  s.summary = %q{nimble api is used to create person and company on the nimble platform using api's}
  s.description = %q{
    This gem is used to create person and company on the nimble platform using api's
  }
  s.files = Dir['lib/**/*.rb']
  s.add_dependency "httparty"
  s.require_paths = ["lib"]
  s.license       = 'MIT'
end