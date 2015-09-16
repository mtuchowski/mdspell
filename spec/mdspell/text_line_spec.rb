describe MdSpell::TextLine do
  let(:md_p_element) { Kramdown::Element.new(:p) }
  let(:md_header_element) { Kramdown::Element.new(:header) }
  let(:md_text_element) { Kramdown::Element.new(:text, "Joe's shop", nil, location: 42) }
  let(:md_other_text_element) { Kramdown::Element.new(:text, 'text', nil, location: 42) }
  let(:md_quote_element) { Kramdown::Element.new(:smart_quote, :lsquo, nil, location: 42) }
  let(:md_empty_text_element) { Kramdown::Element.new(:text, nil, nil, location: 42) }
  let(:md_empty_quote_element) { Kramdown::Element.new(:smart_quote, nil, nil, location: 42) }
  let(:md_text_element_diff_location) { Kramdown::Element.new(:text, 'test', nil, location: 41) }

  subject { MdSpell::TextLine.new(md_text_element) }

  context 'attributes' do
    it { is_expected.to respond_to :location }
    it { is_expected.to respond_to :content }
    it { is_expected.to respond_to :words }
    it { is_expected.to respond_to :<< }
  end

  context '#initialize' do
    it 'should expect Kramdown::Element as argument' do
      expect { MdSpell::TextLine.new }.to raise_error ArgumentError
      expect { MdSpell::TextLine.new('test') }.to raise_error ArgumentError
    end
  end

  context '#location' do
    it 'should return proper value' do
      expect(subject.location).to eq 42
    end
  end

  context '#content' do
    it 'should contain proper text' do
      expect(subject.content).to eq "Joe's shop"
    end
  end

  context '#words' do
    it 'should return proper content' do
      expect(subject.words).to eq ["Joe's", 'shop']
    end
  end

  context '#<<' do
    it 'should accept only Kramdown::Element' do
      expect { subject << 'p_element' }.to raise_error ArgumentError
      expect { subject << nil }.to raise_error ArgumentError
      expect { subject << md_empty_text_element }.not_to raise_error
      expect { subject << md_empty_quote_element }.not_to raise_error
    end

    context 'when given text element' do
      it 'should update content' do
        subject << md_other_text_element
        expect(subject.content).to eq "Joe's shop text"
      end
    end

    context 'when given smart quote element' do
      let(:lsquo_element) { Kramdown::Element.new(:smart_quote, :lsquo, nil, location: 42) }
      let(:rsquo_element) { Kramdown::Element.new(:smart_quote, :rsquo, nil, location: 42) }
      let(:ldquo_element) { Kramdown::Element.new(:smart_quote, :ldquo, nil, location: 42) }
      let(:rdquo_element) { Kramdown::Element.new(:smart_quote, :rdquo, nil, location: 42) }

      it 'should translate to content properly' do
        subject << lsquo_element
        expect(subject.content).to eq "Joe's shop'"
        subject << ldquo_element
        expect(subject.content).to eq "Joe's shop'\""
        subject << rsquo_element
        expect(subject.content).to eq "Joe's shop'\"'"
        subject << rdquo_element
        expect(subject.content).to eq "Joe's shop'\"'\""
      end

      it 'should properly concatenate words' do
        subject << md_quote_element
        subject << md_other_text_element
        expect(subject.content).to eq "Joe's shop'text"
        subject << md_other_text_element
        expect(subject.content).to eq "Joe's shop'text text"
      end
    end

    context 'when given element from different location' do
      it 'should not update content' do
        subject << md_text_element_diff_location
        expect(subject.content).to eq "Joe's shop"
      end
    end
  end

  context '::scan' do
    let(:complete_md) do
      Kramdown::Document.new(File.read('spec/examples/complete.md'), input: 'GFM')
    end

    it 'should expect Kramdown::Document as argument' do
      expect { MdSpell::TextLine.scan }. to raise_error ArgumentError
    end

    it 'should find proper lines' do
      lines = MdSpell::TextLine.scan(complete_md)

      expect(lines).to have(20).items

      expect(lines[0].content).to eq 'First header'
      expect(lines[1].content).to eq 'Second Header'
      expect(lines[2].content).to eq 'Third Header'
      expect(lines[3].content).to eq 'Fourth Header'
      expect(lines[4].content).to eq 'Fifth Header'
      expect(lines[5].content).to eq 'First paragraph'
      expect(lines[6].content).to eq 'Second paragraph'
      expect(lines[7].content).to eq 'Multi-line'
      expect(lines[8].content).to eq 'paragraph'
      expect(lines[9].content).to eq 'Block-quote'
      expect(lines[10].content).to eq 'Third paragraph (with parenthesis).'
      expect(lines[11].content).to eq 'Another block-quote'
      expect(lines[12].content).to eq 'Nested block-quote'
      expect(lines[13].content).to eq 'Unordered'
      expect(lines[14].content).to eq 'List'
      expect(lines[15].content).to eq 'Ordered'
      expect(lines[16].content).to eq 'List'
      expect(lines[17].content).to eq 'Multi-line paragraph'
      expect(lines[18].content).to eq 'as list item'
      expect(lines[19].content).to eq "Two quotes: That's one, and here's the other"
    end
  end
end
