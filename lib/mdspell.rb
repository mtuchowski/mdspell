require_relative 'mdspell/version'
require_relative 'mdspell/cli'
require_relative 'mdspell/configuration'
require_relative 'mdspell/spell_checker'
require_relative 'mdspell/text_line'
require_relative 'mdspell/typo'

require 'rainbow'

# This module holds all the MdSpell code (except mdspell shell command).
module MdSpell
  # rubocop:disable Metrics/AbcSize
  def self.run(argv)
    cli = MdSpell::CLI.new
    cli.run argv

    # Spell-check each file.
    cli.files.each do |filename|
      spell_checker = SpellChecker.new(filename)

      verbose "Spell-checking #{spell_checker.filename}..."

      spell_checker.typos.each do |typo|
        error "#{spell_checker.filename}:#{typo.line.location}: #{typo.word}"
      end
    end

    exit_if_had_errorss
  end

  # Private class methods

  def self.verbose(str)
    puts str if Configuration[:verbose]
  end
  private_class_method :verbose

  def self.error(str)
    @had_errors = true
    puts Rainbow(str).red
  end
  private_class_method :error

  def self.exit_if_had_errorss
    if @had_errors
      # If exit will be suppressed (line in tests or using at_exit), we need to clean @had_errors
      @had_errors = false
      exit(1)
    end
  end
end
