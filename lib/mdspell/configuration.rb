require 'mixlib/config'

module MdSpell
  # Stores configuration from both command line and config file.
  class Configuration
    extend Mixlib::Config
  end
end
