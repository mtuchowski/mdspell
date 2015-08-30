require 'mdspell/typo'

describe MdSpell::Typo do
  let(:text_line) do
    MdSpell::TextLine.new(Kramdown::Element.new(:text, 'black rabit', nil, location: 42))
  end
  let(:misspelled_word) { 'rabit' }
  let(:suggested_word) { 'rabbit' }

  subject { MdSpell::Typo.new(text_line, misspelled_word, [suggested_word]) }

  context 'attributes' do
    it { is_expected.to respond_to :line }
    it { is_expected.to respond_to :word }
    it { is_expected.to respond_to :suggestions }
  end

  context '#initialize' do
    it 'should expect TextLine as first argument' do
      expect do
        MdSpell::Typo.new(nil, misspelled_word, [suggested_word])
      end.to raise_error ArgumentError

      expect do
        MdSpell::Typo.new('black rabit', misspelled_word, [suggested_word])
      end.to raise_error ArgumentError

      expect do
        MdSpell::Typo.new(text_line, misspelled_word, [suggested_word])
      end.not_to raise_error
    end

    it 'should expect word as second argument' do
      expect { MdSpell::Typo.new(text_line, nil, [suggested_word]) }.to raise_error ArgumentError
      expect { MdSpell::Typo.new(text_line, :c, [suggested_word]) }.to raise_error ArgumentError

      expect do
        MdSpell::Typo.new(text_line, misspelled_word, [suggested_word])
      end.not_to raise_error
    end

    it 'should expect array as third argument' do
      expect { MdSpell::Typo.new(text_line, misspelled_word, nil) }.to raise_error ArgumentError
      expect { MdSpell::Typo.new(text_line, misspelled_word, 'a') }.to raise_error ArgumentError

      expect { MdSpell::Typo.new(text_line, misspelled_word, []) }.not_to raise_error
      expect do
        MdSpell::Typo.new(text_line, misspelled_word, [suggested_word])
      end.not_to raise_error
    end
  end

  context '#line' do
    it 'should return proper object' do
      expect(subject.line).to be text_line
    end
  end

  context '#word' do
    it 'should return proper word' do
      expect(subject.word).to eq misspelled_word
    end
  end

  context '#suggestions' do
    it 'should be an array' do
      expect(subject.suggestions).to be_instance_of Array
    end

    it 'should return proper items' do
      expect(subject.suggestions).to have(1).item
      expect(subject.suggestions).to eq [suggested_word]
    end
  end
end
