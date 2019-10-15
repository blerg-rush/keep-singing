RSpec.configure do |config|
  config.before :each do
    stub_request(:any, /localhost:9200/)
      .to_return(body: '<html>success?</html>', status: 200)
  end
end
