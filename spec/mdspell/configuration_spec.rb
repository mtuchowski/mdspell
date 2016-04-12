describe MdSpell::Configuration do
  def run_app(args = [])
    MdSpell::CLI.new.run(args)
  end

  context ':config_file' do
    it "should default to '~/.mdspell'" do
      run_app
      expect(MdSpell::Configuration[:config_file]).to eq '~/.mdspell'
    end

    context 'command line argument' do
      it "uses '-c' short flag" do
        run_app(['-c', 'short'])
        expect(MdSpell::Configuration[:config_file]).to eq 'short'
      end

      it "uses '--config' long flag" do
        run_app(['--config', 'long'])
        expect(MdSpell::Configuration[:config_file]).to eq 'long'
      end
    end

    context 'if file exists' do
      it 'should merge its content' do
        run_app(['-c', 'spec/examples/mdspell.config'])
        expect(MdSpell::Configuration[:language]).to eq 'pl'
      end
    end
  end

  context ':language' do
    it "should default to 'en_US'" do
      run_app
      expect(MdSpell::Configuration[:language]).to eq 'en_US'
    end

    context 'command line argument' do
      it "uses '-l' short flag" do
        run_app(['-l', 'en_GB'])
        expect(MdSpell::Configuration[:language]).to eq 'en_GB'
      end

      it "uses '--language' long flag" do
        run_app(['--language', 'uk'])
        expect(MdSpell::Configuration[:language]).to eq 'uk'
      end
    end
  end

  context ':verbose' do
    it 'should default to false' do
      run_app
      expect(MdSpell::Configuration[:verbose]).to eq false
    end

    context 'command line argument' do
      it "uses '-v' short flag" do
        run_app(['-v'])
        expect(MdSpell::Configuration[:verbose]).to eq true
      end

      it "uses '--verbose' long flag" do
        run_app(['--verbose'])
        expect(MdSpell::Configuration[:verbose]).to eq true
      end
    end
  end

  context ':version' do
    it 'should return proper string' do
      run_app
      expect(MdSpell::Configuration[:version]).to eq MdSpell::VERSION
    end

    context 'command line argument' do
      it "uses '-V' short flag" do
        expect do
          run_app(['-V'])
        end.to raise_error SystemExit
      end

      it "uses '--version' long flag" do
        expect do
          run_app(['--version'])
        end.to raise_error SystemExit
      end
    end
  end
end
