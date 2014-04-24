$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "access_summary_log/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "access_summary_log"
  s.version     = AccessSummaryLog::VERSION
  s.authors     = ["Yoshihiro Kameda"]
  s.email       = ["kameda.sbng@gmail.com"]
  s.homepage    = "http://github.com/kmdsbng/access_summary_log"
  s.summary     = "access_summary_log provide readable log for development."
  s.description = "access_summary_log provide readable log for development."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0"

end
