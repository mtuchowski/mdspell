describe MdSpell::Configuration do
  before(:each) do
    MdSpell::CLI.new.run(['mdspell'])
  end

  context ':config_file' do
    it "should default to '~/.mdspell'" do
      expect(MdSpell::Configuration[:config_file]).to eq '~/.mdspell'
    end
  end

  context ':language' do
    it "should default to 'en_US'" do
      expect(MdSpell::Configuration[:language]).to eq 'en_US'
    end
  end

  context ':verbose' do
    it 'should default to false' do
      expect(MdSpell::Configuration[:verbose]).to eq false
    end
  end

  context ':version' do
    it 'should return proper string' do
      expect(MdSpell::Configuration[:version]).to eq MdSpell::VERSION
    end
  end
end
