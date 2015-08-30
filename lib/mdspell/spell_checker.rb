require_relative 'configuration'

require 'kramdown'
require 'ffi/aspell'

module MdSpell
  # A class for finding spelling errors in document.
  class SpellChecker
    # Name of the file this object was created from.
    attr_reader :filename

    # A Kramdown::Document object containing the parsed markdown document.
    attr_reader :document

    # Create a new instance from specified file.
    # @param filename [String] a name of file to load.
    def initialize(filename)
      @filename = filename
      @document = Kramdown::Document.new(File.read(filename), input: 'GFM')
    end

    # Returns found spelling errors.
    def typos
      results = []

      FFI::Aspell::Speller.open(Configuration[:language]) do |speller|
        TextLine.scan(document).each do |line|
          line.words.each do |word|
            unless speller.correct? word
              results << Typo.new(line, word, speller.suggestions(word))
            end
          end
        end
      end

      results
    end
  end
end
