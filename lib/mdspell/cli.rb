require 'mixlib/cli'

module MdSpell
  # Class responsible for parsing all of command line arguments.
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($PROGRAM_NAME)} [options] [FILE.md|DIR ...]"

    option :config_file,
           short: '-c FILE',
           long: '--config FILE',
           description: 'The configuration file to use'

    option :language,
           short: '-l LANG',
           long: '--language LANG',
           description: 'Set documents language'

    option :ignored,
           short: '-i IGNORED1,IGNORED2,...',
           long: '--ignored IGNORED1,IGNORED2,...',
           description: 'CSV of expressions to be ignored',
           proc: Proc.new { |csv| csv.split(',') }

    option :verbose,
           short: '-v',
           long: '--[no-]verbose',
           description: 'Be more/less verbose',
           boolean: true

    option :version,
           on: :tail,
           short: '-V',
           long: '--version',
           description: 'Show version',
           boolean: true,
           proc: proc { puts MdSpell::VERSION },
           exit: 0

    def run(options)
      raise ArgumentError, 'expected Array of command line options' unless options.is_a? Array

      # Start clean
      MdSpell::Configuration.reset

      parse_options(options)
      # Load optional config file if it's present.
      if config[:config_file]
        config_filename = File.expand_path(config[:config_file])
        MdSpell::Configuration.from_file(config_filename) if File.exist?(config_filename)
      end

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
      cli_arguments
    end
  end
end
