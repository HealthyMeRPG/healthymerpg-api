class OmhShimConfig
  ##
  # Returns the configuration for the Open mHealth Shim Server for
  # the current running rails environment
  def self.config
    # reads the config/omh_shim.yml file, returning the values inside the current environment
    @config ||= begin
      YAML::load_file(Rails.root.join('config', 'omh_shim.yml')).with_indifferent_access[Rails.env]
    end
  end
end
