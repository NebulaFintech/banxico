RSpec.describe Banxico::WebServices::ExchangeRate do
  let(:client) { Banxico::WebServices::ExchangeRate.new }
  it "get usd to mxn exchange rate" do
    exchange_rate = client.do_request(:usd)
    expect(exchange_rate).to be_a(Banxico::ExchangeRate)
    expect(exchange_rate.currency).to eq(:usd)
    expect(exchange_rate.date).to eq(Date.today)
    expect(exchange_rate.value).to be_a(Float)
  end

  it "get udis to mxn exchange rate" do
    exchange_rate = client.do_request(:udis)
    expect(exchange_rate).to be_a(Banxico::ExchangeRate)
    expect(exchange_rate.currency).to eq(:udis)
    expect(exchange_rate.date).to eq(Date.today)
    expect(exchange_rate.value).to be_a(Float)
  end
end
