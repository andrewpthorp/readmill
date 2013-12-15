require 'spec_helper'

describe Readmill do

  describe '.methods' do
    describe '.configure' do
      it 'should allow you to set global configuration options' do
        Readmill.configure do |c|
          c.client_id = 'somerandomkey'
        end
        expect(Readmill.configuration.client_id).to eq('somerandomkey')
      end
    end
  end

  describe Readmill::Configuration do
    let (:config) { Readmill::Configuration.new }

    describe '.defaults' do
      { client_id: nil, timeout: 10, open_timeout: 10,
        adapter: Faraday.default_adapter }.each do |k, v|
        it "should default #{k} to #{v}" do
          expect(config.send(k)).to eq(v)
        end
      end
    end

    describe '#methods' do
      describe '#values' do
        before do
          config.client_id = 'abc123'
        end

        describe '#values' do
          it 'should return a hash of configuration settings' do
            expect(config.values).to eq({
              client_id: 'abc123',
              timeout: 10,
              open_timeout: 10,
              adapter: Faraday.default_adapter
            })
          end
        end
      end
    end

  end

end
