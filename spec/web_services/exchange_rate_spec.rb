RSpec.describe Banxico::WebServices::ExchangeRate do
  let(:client) { Banxico::WebServices::ExchangeRate.new }
  it "get usd to mxn exchange rate" do
    exchange_rate = client.do_wsdl_request(:usd)
    expect(exchange_rate).to be_a(Banxico::ExchangeRate)
    expect(exchange_rate.currency).to eq(:usd)
    expect(exchange_rate.date).to eq(Date.today)
    expect(exchange_rate.value).to be_a(Float)
  end

  it "get udis to mxn exchange rate" do
    exchange_rate = client.do_wsdl_request(:udis)
    expect(exchange_rate).to be_a(Banxico::ExchangeRate)
    expect(exchange_rate.currency).to eq(:udis)
    expect(exchange_rate.date).to eq(Date.today)
    expect(exchange_rate.value).to be_a(Float)
  end

  it "gets historical udids exchange rate" do
    exchange_rates = client.do_historic_request(:udis, {start_year: "2015", end_year: "2015"})
    expect(exchange_rates).to be_a(Array)
    expect(exchange_rates.first).to be_a(Banxico::ExchangeRate)
    expect(exchange_rates.first.currency).to eq(:udis)
    expect(exchange_rates.first.date).to eq(Date.parse("2015-01-01"))
    expect(exchange_rates.first.value).to be_a(Float)
  end

  it "gets specific date" do
    date = Date.parse("2015-02-01")
    exchange_rates = client.do_historic_request(:udis, {start_year: "2015", end_year: "2015"})
    exchange_rate = Banxico::ExchangeRate.get_date(exchange_rates, date)
    expect(exchange_rate.date).to eq(date)
  end
end
