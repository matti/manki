require 'spec_helper'

describe Manki do
  describe "actions" do
    before :all do
      @m = Manki.new
    end

    it "is initially empty" do
      @m.actions == []
    end

    describe "when navigating" do
      before :each do
        @m = Manki.new
        @m.location "http://localhost:4567"
      end

      it "has one action" do
        expect(@m.actions.size).to eq 1
        expect(@m.actions.first).to be_a Manki::Action
      end

      it "has two actions" do
        @m.location "/other.html"

        expect(@m.actions.size).to eq 2
        expect(@m.actions.first).to be_a Manki::Action
        expect(@m.actions.second).to be_a Manki::Action
      end
    end
  end
end

describe Manki do

  describe Manki::Action::Location do
    before :all do
      m = Manki.new
      m.location "http://localhost:4567"

      @a = m.actions.first
    end

    it "is Manki::Action::Location" do
      expect(@a.class.to_s).to eq "Manki::Action::Location"
    end

    it 'is success' do
      expect(@a.success).to be true
    end

    it 'has started_at and stopped_at' do
      expect(@a.started_at).to be_a Time
      expect(@a.stopped_at).to be_a Time
    end

    it 'has duration' do
      expect(@a.duration).to eq (@a.stopped_at - @a.started_at)
    end

    describe 'before & after' do
      it "have instances" do
        expect(@a.before).to be_a Manki::Action::Before
        expect(@a.after).to be_a Manki::Action::After
      end

      it 'have uri set' do
        expect(@a.before.uri).to be_a URI
        expect(@a.before.uri.to_s).to eq "about:blank"

        expect(@a.after.uri).to be_a URI
        expect(@a.after.uri.to_s).to eq "http://localhost:4567/"
      end

      describe 'code' do
        before :all do
          @m = Manki.new
          @m.location 'http://localhost:4567'
        end

        it 'have codes nil and 200 after one navigation' do
          expect(@m.actions.first.before.code).to eq nil
          expect(@m.actions.first.after.code).to eq 200
        end

        it 'have codes 200 and 404 after second navigation' do
          @m.location "/404"
          expect(@m.actions.second.before.code).to eq 200
          expect(@m.actions.second.after.code).to eq 404
        end
      end

      xit 'has screenshot'
    end

  end
end

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

  xit 'has screenshot' do
    expect(@t.screenshot).to eq "./tmp/lel.png"
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
