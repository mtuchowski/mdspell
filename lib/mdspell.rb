require_relative 'mdspell/version'
require_relative 'mdspell/cli'
require_relative 'mdspell/configuration'
require_relative 'mdspell/spell_checker'
require_relative 'mdspell/text_line'
require_relative 'mdspell/typo'

require 'rainbow'

# This module holds all the MdSpell code (except mdspell shell command).
module MdSpell
  def self.run(argv)
    cli = MdSpell::CLI.new
    cli.run argv
    cli.files.each(&method(:check_file))

    exit_if_had_errors
  end

  # Private class methods

  def self.check_file(filename)
    spell_checker = SpellChecker.new(filename)
    filename = spell_checker.filename

    verbose "Spell-checking #{filename}..."

    spell_checker.typos.each do |typo|
      error "#{filename}:#{typo.line.location}: #{typo.word}"
    end
  end
  private_class_method :check_file

  def self.verbose(str)
    puts str if Configuration[:verbose]
  end
  private_class_method :verbose

  def self.error(str)
    @had_errors = true
    puts Rainbow(str).red
  end
  private_class_method :error

  def self.exit_if_had_errors
    if @had_errors
      # If exit will be suppressed (line in tests or using at_exit), we need to clean @had_errors
      @had_errors = false
      exit(1)
    end
  end
  private_class_method :exit_if_had_errors
end
