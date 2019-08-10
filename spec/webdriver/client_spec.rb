RSpec.describe Webdriver::Client do
  let(:subject) { @client }

  it "instantiates" do
    expect(subject).to be_an_instance_of(Webdriver::Client)
  end

  it do
    expect(subject.status).to match hash_including "ready" => true
  end

  it do
    expect(subject.sessions).to eq []
  end

  it do
    expect(subject.session!).to be_an_instance_of Webdriver::Session
  end
end
