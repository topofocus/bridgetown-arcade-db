# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "bridgetown", ENV["BRIDGETOWN_VERSION"] if ENV["BRIDGETOWN_VERSION"]
gem "arcadedb", path: "/home/ubuntu/hieronymus/arcadedb"
gem "arcade-time-graph", path: "/home/ubuntu/hieronymus/arcade-time-graph"

group :test do
  gem "minitest"
  gem "minitest-reporters"
  gem "shoulda"
end

