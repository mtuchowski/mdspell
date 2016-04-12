describe MdSpell do
  let(:simple) { 'spec/examples/simple.md' }
  let(:with_errors) { 'spec/examples/with_errors.md' }
  let(:args_without_errors) { [[], [simple]] }
  let(:args_with_errors) { [[with_errors]] }

  it { is_expected.to respond_to :run }

  context '#run' do
    context 'if there were no errors' do
      it 'should exit without error' do
        args_without_errors.each do |argv|
          expect { subject.run argv }.not_to raise_error
        end
      end
    end

    context 'if there were errors' do
      it 'should exit with error code' do
        args_with_errors.each do |argv|
          expect { subject.run argv }.to raise_error SystemExit
        end
      end
    end
  end
end
