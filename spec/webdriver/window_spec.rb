RSpec.describe Webdriver::Client do
  let(:subject) { @client.session.windows.first }

  it do
    expect(subject).to be_an_instance_of(Webdriver::Window)
  end

  it do
    expect(subject).to respond_to :id
  end

  it do
    subject.maximize
  end

  it do
    subject.minimize
  end

end
