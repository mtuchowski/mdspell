require 'mixlib/cli'

module MdSpell
  # Class responsible for parsing all of command line arguments.
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($PROGRAM_NAME)} [options] [FILE.md|DIR ...]"

    def run(argv = ARGV)
      parse_options(argv)
    end
  end
end
