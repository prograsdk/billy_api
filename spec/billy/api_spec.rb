RSpec.describe BillyApi do
  it "has a version number" do
    expect(BillyApi::VERSION).not_to be nil
  end

  describe BillyApi::Client do
    before do
      BillyApi.configure do |config|
        config.api_key = "12345678987654321"
      end
    end
    describe '.request' do
      it "calls correct endpoint for a resource" do
        allow(RestClient::Request).to receive(:execute).and_return(
          instance_double(RestClient::Response,
            body: "{}"
          )
        )

        call = BillyApi::Client.request(:get, 'clients', 5)
        expect(call).to be_a Hash
      end
    end
  end
end
