require 'mdspell/cli'
require 'mdspell/configuration'
require 'mdspell/version'

require 'rainbow'

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
      verbose "Spell-checking #{filename}..."
    end
  end

  def self.verbose(str)
    puts str if Configuration[:verbose]
  end
  private_class_method :verbose

  def self.error(str)
    puts Rainbow(str).red
  end
  private_class_method :error
end
