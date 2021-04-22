RSpec.describe Symbolize do
  it "has a version number" do
    expect(Symbolize::VERSION).not_to be nil
  end

  it "extends String class" do
    expect("This is a test".symbolize).to eq(:this_is_a_test)
  end

  it "has a symbolize method" do
    expect(Symbolize.symbolize('This is a test')).to eq(:this_is_a_test)
  end

  it "has default translations" do
    expect(Symbolize.translations.underscore).to eq([' '])
    expect(Symbolize.translations.remove).to eq(['\'','(',')'])
  end

  it "can translate block" do
    Symbolize.translate do |trans|
      trans.to_underscore('!@£$%^&')
    end
    expect(Symbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:t_h_i_s_i_s__a__t_est)

    Symbolize.translate do |trans|
      trans.to_remove('!@£$%^&')
    end
    expect(Symbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:this_is_a_test)
  end
end
