require 'mixlib/cli'

module MdSpell
  # Class responsible for parsing all of command line arguments.
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($PROGRAM_NAME)} [options] [FILE.md|DIR ...]"

    option :config_file,
           short: '-c',
           long: '--config FILE',
           description: 'The configuration file to use',
           default: '~/.mdspell'

    option :language,
           short: '-l',
           long: '--language LANG',
           description: 'Set documents language',
           default: 'en_US'

    option :verbose,
           short: '-v',
           long: '--[no-]verbose',
           description: 'Be more/less verbose',
           boolean: true,
           default: false

    option :version,
           on: :tail,
           short: '-V',
           long: '--version',
           description: 'Show version',
           boolean: true,
           proc: proc { puts MdSpell::VERSION },
           exit: 0,
           default: MdSpell::VERSION

    def run(argv = ARGV)
      parse_options(argv)

      # Load optional config file if it's present.
      config_filename = File.expand_path(config[:config_file])
      MdSpell::Configuration.from_file(config_filename) if File.exist?(config_filename)

      # Store command line configuration options.
      MdSpell::Configuration.merge!(config)
    end

    # List of markdown files from argument list.
    def files
      cli_arguments.each_with_index do |filename, index|
        if Dir.exist?(filename)
          cli_arguments[index] = Dir["#{filename}/**/*.md"]
        end
      end
      cli_arguments.flatten!
    end
  end
end
