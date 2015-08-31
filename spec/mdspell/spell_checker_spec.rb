describe MdSpell::SpellChecker do
  let(:simple) { MdSpell::SpellChecker.new('spec/examples/simple.md') }
  let(:with_errors) { MdSpell::SpellChecker.new('spec/examples/with_errors.md') }
  let(:from_stdin) do
    allow(STDIN).to receive(:read) { '# Header' }
    MdSpell::SpellChecker.new('-')
  end

  context 'attributes' do
    subject { simple }

    it { is_expected.to respond_to :filename }
    it { is_expected.to respond_to :document }
    it { is_expected.to respond_to :typos }
  end

  context '#initialize' do
    it 'should expect filename' do
      expect {  MdSpell::SpellChecker.new }.to raise_error ArgumentError
    end

    it 'should fail if given wrong filename' do
      expect { MdSpell::SpellChecker.new('not_existing.md') }.to raise_error Errno::ENOENT
    end

    it "should read from stdin if given '-' as filename" do
      allow(STDIN).to receive(:read) { '# Header' }
      expect { MdSpell::SpellChecker.new('-') }.not_to raise_error
    end
  end

  context '#filename' do
    it 'should return proper path' do
      expect(simple.filename).to eq 'spec/examples/simple.md'
      expect(with_errors.filename).to eq 'spec/examples/with_errors.md'
    end

    context 'if initialized from stdin' do
      it "should return 'stdin'" do
        expect(from_stdin.filename).to eq 'stdin'
      end
    end
  end

  context '#document' do
    it 'should be of proper type' do
      expect(simple.document).to be_instance_of Kramdown::Document
      expect(with_errors.document).to be_instance_of Kramdown::Document
    end
  end

  context '#typos' do
    it 'should return empty array if there are no errors' do
      expect(simple.typos).to have(0).items
      expect(from_stdin.typos).to have(0).items
    end

    it 'should return proper results' do
      typos = with_errors.typos

      expect(typos).to have(4).items
      expect(typos[0].word).to eq 'mispelled'
      expect(typos[1].word).to eq 'qiute'
      expect(typos[2].word).to eq 'actualy'
      expect(typos[3].word).to eq 'tobe'
    end

    it 'should use configured language' do
      prev_language = MdSpell::Configuration[:language]
      MdSpell::Configuration[:language] = 'es'

      typos = MdSpell::SpellChecker.new('spec/examples/spanish_errors.md').typos

      expect(typos).to have(3).items
      expect(typos[0].word).to eq 'vivira'
      expect(typos[1].word).to eq 'Oscar'
      expect(typos[2].word).to eq 'Wilde'

      MdSpell::Configuration[:language] = prev_language
    end
  end
end
