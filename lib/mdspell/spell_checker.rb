require 'kramdown'

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
      []
    end
  end
end
