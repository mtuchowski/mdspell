require 'mixlib/cli'

module MdSpell
  # Class responsible for parsing all of command line arguments.
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($PROGRAM_NAME)} [options] [FILE.md|DIR ...]"

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

    def run(argv = ARGV)
      parse_options(argv)
    end
  end
end
