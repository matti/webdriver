RSpec.describe Webdriver::Client do
  let(:subject) { @client.session! }

  it do
    expect(subject).to be_an_instance_of(Webdriver::Session)
  end

  it do
    expect(subject).to respond_to :id
  end

  it do
    expect(subject.windows.size).to eq 1
  end
end
