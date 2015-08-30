module MdSpell
  # A wrapper class for single, misspelled word.
  class Typo
    # A TextLine that contains this error.
    attr_reader :line

    # A misspelled word.
    attr_reader :word

    # A list of suggestions for this error.
    attr_reader :suggestions

    # Create a new SpellingError.
    # @param line [TextLine] the TextLine that contains the error.
    # @param word [String] the misspelled word.
    # @param suggestions [Array] an array of suggestions for the word.
    def initialize(line, word, suggestions)
      assert_proper_line_type(line)
      assert_proper_word_type(word)
      assert_proper_suggestions_type(suggestions)

      @line = line
      @word = word
      @suggestions = suggestions
    end

    private

    def assert_proper_line_type(line)
      fail ArgumentError, "expected TextLine, got #{line.class.inspect}" unless
        line.class == TextLine
    end

    def assert_proper_word_type(word)
      fail ArgumentError, "expected String, got #{word.class.inspect}" unless
        word.class == String
    end

    def assert_proper_suggestions_type(suggestions)
      fail ArgumentError, "expected Array, got #{suggestions.class.inspect}" unless
        suggestions.class == Array
    end
  end
end
