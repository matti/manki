require 'spec_helper'

describe Manki::Transition do
  before :all do
    m = Manki.new
    @t = m.location "http://localhost:4567"
  end

  it 'has uri' do
    expect(@t.uri).to be_a URI
    expect(@t.uri.to_s).to eq "http://localhost:4567"
  end

  it 'has performed?' do
    expect(@t.performed?).to be true
  end

  it 'has start' do
    expect(@t.started_at).to be_a Time
  end

  it 'has stop' do
    expect(@t.stopped_at).to be_a Time
  end

  it 'has code' do
    expect(@t.code).to eq 200
  end

  it 'has duration' do
    expect(@t.duration).to eq (@t.stopped_at - @t.started_at)
  end
end

describe Manki do
  it 'has a version number' do
    expect(Manki::VERSION).not_to be nil
  end

  describe 'instantiation' do
    it 'instantiates without arguments' do
      expect(Manki.new).to be_a Manki
    end

    it 'accepts a hash of options' do
      expect(Manki.new {}).to be_a Manki
    end
  end

  describe 'instance' do
    before :each do
      @m = Manki.new
    end

    describe 'initialized' do
      describe 'attributes' do
        it 'window is an Winow' do
          expect(@m.window).to be_a Manki::Window
        end

        it 'windows has one window' do
          expect(@m.windows.size).to eq 1
          expect(@m.windows["0"]).to be_a Manki::Window
        end

        it 'html is empty string' do
          expect(@m.html).to eq ""
        end

        it 'text is empty string' do
          expect(@m.text).to eq ""
        end
      end
    end

    describe 'location' do
      describe 'when URI' do
        it 'raises Error::SchemeNotSupported if not http or https' do
          expect {
            @m.location "http://notexistinghost/path"
            @m.location "https://notexistinghost/path"
          }.to raise_error Manki::Error::HostNotFound, "Host 'notexistinghost' not found."

          expect {
            @m.location "asdf://host/path"
          }.to raise_error Manki::Error::SchemeNotSupported, "Scheme 'asdf' not supported."
        end
      end

      it 'raises Error:Navigation if first location is a path' do
        expect {
          @m.location "/"
        }.to raise_error Manki::Error::Navigation
      end

      it 'returns Manki::Transition' do
        expect(
          @m.location 'http://localhost:4567'
        ).to be_a Manki::Transition
      end

      describe 'when navigating' do
        before :each do
          @m.location 'http://localhost:4567'
        end

        it 'has html' do
          expect(@m.html).to include "<h1>MankiWorld</h1>"
        end

        it 'has text' do
          expect(@m.text).to eq "MankiWorld Go to other"
        end

        it 'still one window' do
          expect(@m.windows.size).to eq 1
        end

        describe 'subsequent navigation' do
          it 'to /other.html' do
            expect(
              @m.location '/other.html'
            ).to be_a Manki::Transition

            expect(@m.windows.size).to eq 1
            expect(@m.html).to include "<h1>Other</h1>"
            expect(@m.text).to eq "Other"
          end
        end
      end
    end

  end
end
