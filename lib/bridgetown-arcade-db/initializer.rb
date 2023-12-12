# frozen_string_literal: true

require "arcade"
require "arcade-time-graph"
require "active_support/configuration_file"
require "zeitwerk"

module BridgetownArcadeDb

  def self.load_models(config)
    loader = Zeitwerk::Loader.new
    root= Pathname.new( config.root_dir )
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
   Arcade::Init.connect Bridgetown.environment
end
