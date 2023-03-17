# frozen_string_literal: true

require_relative 'lib/helpscout/mailbox/v2/reports/version'

Gem::Specification.new do |spec|
  spec.name          = 'helpscout-mailbox-v2-reports'
  spec.version       = Helpscout::Mailbox::V2::Reports::VERSION
  spec.authors       = ['Jason Jacob']
  spec.email         = ['hipcog@gmail.com']

  spec.summary       = 'REST client for HelpScout V2 mailbox reports'
  spec.homepage      = 'https://github.com/jayco/helpscout-mailbox-v2-reports.git'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 6', '< 8'
  spec.add_runtime_dependency 'helpscout-mailbox-v2-client', '~> 0.1.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.8'
end
