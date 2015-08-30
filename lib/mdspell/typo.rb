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
      Typo.assert_proper_line_type(line)
      Typo.assert_proper_word_type(word)
      Typo.assert_proper_suggestions_type(suggestions)

      @line = line
      @word = word
      @suggestions = suggestions
    end

    # Private class methods

    def self.assert_proper_line_type(line)
      fail ArgumentError, "expected TextLine, got #{@element.class.inspect}" unless
        line.class == TextLine
    end
    private_class_method :assert_proper_line_type

    def self.assert_proper_word_type(word)
      fail ArgumentError, "expected String, got #{@word.class.inspect}" unless
        word.class == String
    end
    private_class_method :assert_proper_word_type

    def self.assert_proper_suggestions_type(suggestions)
      fail ArgumentError, "expected Array, got #{@suggestions.class.inspect}" unless
        suggestions.class == Array
    end
    private_class_method :assert_proper_suggestions_type
  end
end
