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
      FFI::Aspell::Speller.open(Configuration[:language]) do |speller|
        TextLine.scan(document).each do |line|
          line.words.each do |word|
            next if ignored? word
            unless speller.correct? word
              results << Typo.new(line, word, speller.suggestions(word))
            end
          end
        end
      end

      results
    end

    private

    def ignored?(word)
      # For each ignored word / expression, join them together with
      # An atomic grouping:
      # http://ruby-doc.org/core-2.1.1/Regexp.html#class-Regexp-label-Atomic+Grouping
      # And an alternation using the '|' character:
      # http://ruby-doc.org/core-2.1.1/Regexp.html#class-Regexp-label-Alternation
      # Compile it the result into a single regular expression,
      # and save it as an instance variable so we don't need to recompile.
      return false if Configuration[:ignored].empty?
      @ignored ||= begin
        Regexp.new(Configuration[:ignored].map do |e|
          "(?>#{e})"
        end.join('|'), Regexp::EXTENDED | Regexp::IGNORECASE)
      end
      @ignored =~ word
    end
  end
end
