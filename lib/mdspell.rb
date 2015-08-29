require 'mdspell/cli'
require 'mdspell/configuration'
require 'mdspell/version'

# This module holds all the MdSpell code (except mdspell shell command).
module MdSpell
  def self.run
    cli = MdSpell::CLI.new
    cli.run

    # Scan directories recursively for markdown files.
    cli.cli_arguments.each_with_index do |filename, index|
      if Dir.exist?(filename)
        cli.cli_arguments[index] = Dir["#{filename}/**/*.md"]
      end
    end
    cli.cli_arguments.flatten!

    cli.cli_arguments.each do |filename|
      puts "Spell-checking #{filename}..." if Configuration[:verbose]
    end
  end
end
