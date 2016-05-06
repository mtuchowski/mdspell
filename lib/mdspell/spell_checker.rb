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
      if filename == '-'
        @filename = 'stdin'
        text = STDIN.read
      else
        @filename = filename
        text = File.read(filename)
      end

      @document = Kramdown::Document.new(text, input: 'GFM')
    end

    # Returns found spelling errors.
    def typos
      results = []
      ignored = Regexp.new(Configuration[:ignored].join('|'),  Regexp::EXTENDED | Regexp::IGNORECASE) unless Configuration[:ignored].empty?
      FFI::Aspell::Speller.open(Configuration[:language]) do |speller|
        TextLine.scan(document).each do |line|
          line.words.each do |word|
            next if ignored =~ word
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
