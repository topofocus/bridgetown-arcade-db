# frozen_string_literal: true

require "arcade"
require "arcade-time-graph"
require "active_support/configuration_file"
require "zeitwerk"

module BridgetownArcadeDb

  def self.load_models(config)
    loader = Zeitwerk::Loader.new
    puts "Dir"
    root= Pathname.new( config.root_dir )
   puts configuration(config)[:modeldir] # || "model"
   loader.push_dir root.join( configuration(config)[:modeldir] || "model")
    loader.setup
  end
  def self.configuration(config)
    ActiveSupport::ConfigurationFile.parse(File.join(config.root_dir, "config", "arcade.yml"))
  end

  def self.log_writer
    Bridgetown::LogWriter.new.tap(&:enable_prefix)
  end
end

Bridgetown.initializer :"bridgetown-arcade-db" do |config|
   BridgetownArcadeDb.load_models config
   puts "ROOT: #{Arcade::ProjectRoot}"
   Arcade.const_set :ProjectRoot, Pathname.new( config.root_dir )
   Arcade::Init.connect Bridgetown.environment
end
