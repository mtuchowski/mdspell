require 'mixlib/config'

module MdSpell
  # Stores configuration from both command line and config file.
  class Configuration
    extend Mixlib::Config

    config_strict_mode true

    default :config_file, '~/.mdspell'
    default :language, 'en_US'
    default :ignored, []
    default :verbose, false
    default :version, VERSION
  end
end
