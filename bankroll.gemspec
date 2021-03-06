# frozen_string_literal: true

require_relative "lib/bankroll/version"

Gem::Specification.new do |spec|
  spec.name = "bankroll"
  spec.version = Bankroll::VERSION
  spec.authors = ["Nolan J Tait"]
  spec.email = ["nolanjtait@gmail.com"]

  spec.summary = "Mortgage and refinance calculations for ruby"
  spec.description = "Mortgage and refinance calculations for ruby"
  spec.homepage = "https://github.com/nolantait/bankroll"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nolantait/bankroll"
  spec.metadata["changelog_uri"] = "https://github.com/nolantait/bankroll/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) ||
        f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r(\Aexe/)) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-equalizer", "~> 0.3.0"
  spec.add_dependency "dry-initializer", "~> 3.1.1"
  spec.add_dependency "dry-types", "~> 1.5.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
