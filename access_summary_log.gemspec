$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "access_summary_log/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "access_summary_log"
  s.version     = AccessSummaryLog::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of AccessSummaryLog."
  s.description = "TODO: Description of AccessSummaryLog."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0"

  s.add_development_dependency "sqlite3"
end
