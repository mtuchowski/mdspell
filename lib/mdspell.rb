require 'mdspell/cli'
require 'mdspell/version'

# This module holds all the MdSpell code (except mdspell shell command).
module MdSpell
  def self.run
    cli = MdSpell::CLI.new
    cli.run
  end
end
