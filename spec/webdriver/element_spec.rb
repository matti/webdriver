RSpec.describe Webdriver::Element do
  let(:subject) { @client.session!.element("css selector","html") }

  it do
    expect(subject).to respond_to :id
  end

  it do
    expect(subject.tag).to eq "html"
  end

  it do
    expect(subject.element("css selector","body")).to be_an_instance_of(Webdriver::Element)
  end

  describe "child" do
    let(:subject) { @client.session!.element("css selector","html").element("css selector","body") }

    it do
      expect(subject.tag).to eq "body"
    end
  end
end
