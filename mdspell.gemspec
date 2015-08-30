Gem::Specification.new do |s|
  s.name             = 'mdspell'
  s.version          = '0.1.0'

  s.author           = 'Marek Tuchowski'
  s.email            = 'marek@tuchowski.com.pl'
  s.homepage         = 'https://github.com/mtuchowski/mdspell'

  s.license          = 'MIT'
  s.summary          = 'A Ruby markdown spell checking tool.'
  s.description      = 'Check markdown files for spelling errors.'

  s.rdoc_options     = ['--charset', 'UTF-8']
  s.extra_rdoc_files = %w(README.md LICENSE)

  # Manifest
  s.files            = Dir.glob('{lib,bin}/**/*')
  s.test_files       = Dir.glob('{spec}/**/*')
  s.require_paths    = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'kramdown', '~> 1.8'
  s.add_runtime_dependency 'ffi-aspell', '~> 1.1'
end
