describe MdSpell::CLI do
  it { is_expected.to respond_to :run }
  it { is_expected.to respond_to :files }

  context '#run' do
    it 'should expect command line options array' do
      [nil, 'string', 42].each do |argument|
        expect do
          subject.run(argument)
        end.to raise_error ArgumentError, 'expected Array of command line options'
      end
    end
  end

  context '#files' do
    context 'if single file given' do
      it 'should return its path' do
        subject.run(['README.md'])
        expect(subject.files).to have(1).item

        expect(subject.files[0]).to eq 'README.md'
      end
    end

    context 'if directory given' do
      it 'should return all markdown files in that directory' do
        subject.run(['spec/examples'])
        expect(subject.files).to have(4).item

        expect(subject.files).to include('spec/examples/simple.md')
        expect(subject.files).to include('spec/examples/complete.md')
        expect(subject.files).to include('spec/examples/with_errors.md')
        expect(subject.files).to include('spec/examples/spanish_errors.md')
      end
    end

    context 'if both directory and single file given' do
      it 'should return all files' do
        subject.run(['README.md', 'spec/examples'])
        expect(subject.files).to have(5).item

        expect(subject.files).to include('README.md')
        expect(subject.files).to include('spec/examples/simple.md')
        expect(subject.files).to include('spec/examples/complete.md')
        expect(subject.files).to include('spec/examples/with_errors.md')
        expect(subject.files).to include('spec/examples/spanish_errors.md')
      end
    end
  end
end
