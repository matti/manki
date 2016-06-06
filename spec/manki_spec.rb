require 'spec_helper'

describe Manki do
  it 'has a version number' do
    expect(Manki::VERSION).not_to be nil
  end

  describe 'instantiation' do
    it 'requires a hash of options' do
      expect(Manki.new({})).to be_a(Manki)
    end
  end

  describe 'instance' do
    before(:each) do
      @m = Manki.new({
        host: 'http://localhost:4567'
      })
    end

    describe 'get' do
      it 'performs get' do
        @m.get "/"
      end

      it 'sets html' do
        @m.get "/"
        expect(@m.html).to include "<h1>MankiWorld</h1>"
      end
    end

    describe 'html' do
      before(:each) do
        @m = Manki.new({
          host: 'http://localhost:4567'
        })
      end

      it 'is nil' do
        expect(@m.html).to be(nil)
      end
    end
  end
end
