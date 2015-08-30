require 'kramdown'

module MdSpell
  # Containing concatenated text from single document line.
  class TextLine
    # Accepted types of elements.
    ELEMENT_TYPES = [:text, :smart_quote]

    # Line number of the element in document.
    attr_reader :location

    # Textual content of the element.
    attr_reader :content

    # Create a new TextLine from Kramdown::Element object.
    # @param element [Kramdown::Element]
    def initialize(element)
      TextLine.assert_element_type element

      @content = ''
      @location = element.options[:location]
      self << element
    end

    # Return all words in this element.
    def words
      @content.scan(/[\w\']+/)
    end

    # Append Kramdown::Element's content to this element.
    # @param element [Kramdown::Element]
    # @raise ArgumentError if element is in different location.
    def <<(element)
      TextLine.assert_element_type element

      return self unless ELEMENT_TYPES.include? element.type
      return self unless element.options[:location] == @location

      value = element.value

      if element.type == :smart_quote
        appent_quote(value)
      else
        append_text(value)
      end

      self
    end

    private

    def append_text(value)
      return if value.nil? || value.empty?

      value = value.strip
      if @content.empty? || @content[-1] == "'"
        @content += value
      else
        @content += ' ' + value
      end
    end

    def appent_quote(type)
      case type
      when :lsquo, :rsquo
        @content += "'"
      when :ldquo, :rdquo
        @content += '"'
      end
    end

    def self.assert_element_type(elem)
      fail ArgumentError, 'expected Kramdown::Element' unless elem.instance_of? Kramdown::Element
    end
  end
end
