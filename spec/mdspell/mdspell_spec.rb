describe MdSpell do
  let(:simple) { 'spec/examples/simple.md' }
  let(:with_errors) { 'spec/examples/with_errors.md' }
  let(:ignored) { 'mispelled,qiute,actualy,tobe' }

  it { is_expected.to respond_to :run }

  context '#run' do
    context 'if there were no errors' do
      it 'should exit without error' do
        expect { subject.run [] }.not_to raise_error
        expect { subject.run [simple] }.not_to raise_error
        expect do
          allow(STDIN).to receive(:read) { '# Header' }
          subject.run ['-']
        end.not_to raise_error
      end

      it 'should not report anything' do
        expect { subject.run [] }.not_to output.to_stdout
        expect { subject.run [simple] }.not_to output.to_stdout
        expect do
          allow(STDIN).to receive(:read) { '# Header' }
          subject.run ['-']
        end.not_to output.to_stdout
      end
    end

    context 'if there were errors' do
      # rubocop:disable Lint/HandleExceptions:
      def run_safely(args)
        subject.run args
      rescue SystemExit
        # expected
      end

      it 'should exit with error code' do
        expect { subject.run [with_errors] }.to raise_error SystemExit
        expect do
          allow(STDIN).to receive(:read) { 'actualy' }
          subject.run ['-']
        end.to raise_error SystemExit
      end

      it 'should report them' do
        expect { run_safely [with_errors] }.to output(/mispelled|qiute|actualy|tobe/).to_stdout

        expect do
          allow(STDIN).to receive(:read) { 'actualy' }
          run_safely ['-']
        end.to output(/actualy/).to_stdout
      end

      it 'should be able to ignore them' do
        expect { subject.run ['-i', ignored, with_errors] }.to_not raise_error
      end
    end
  end
end
