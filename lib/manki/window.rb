require "tempfile"

class Manki::Window

  def initialize(session:, capybara_window:, name:)
    @session = session
    @capybara_window = capybara_window
    @name = name

    @base_uri = nil
    @history = []
  end

  module Attributes
    def html
      if @history.empty?
        "" # by default it's about blanks <html><body></body></html>
      else
        @capybara_window.session.html
      end
    end

    def text
      @capybara_window.session.text
    end

    def history
      @history
    end

    def code
      @capybara_window.session.driver.status_code
    end
  end

  module Methods
    def current_uri
      URI.parse(@capybara_window.session.driver.current_url)
    end

    def create_action(klass)
      a = klass.new({
        current_uri: current_uri,
        code: code
      })
    end

    def location uri_or_path_string
      a = create_action Manki::Action::Location
      a.start!

      t = Manki::Transition.new
      t.start!

      uri = URI.parse uri_or_path_string

      if uri.scheme
        if ["http", "https"].include? uri.scheme
          @base_uri = URI.parse "#{uri.scheme}://#{uri.host}"
          @base_uri.port = uri.port
        else
          raise Manki::Error::SchemeNotSupported, "Scheme '#{uri.scheme}' not supported."
        end
      else
        unless @base_uri
          raise Manki::Error::Navigation
        end
      end

      full_uri = @base_uri.merge uri
      t.uri = full_uri

      begin
        # {"status"=>"success"}
        status = @capybara_window.session.driver.visit full_uri.to_s
        t.performed = (status["status"] == "success")
        t.code = code

        #TODO: woot
        @capybara_window.session.save_screenshot("./shot.pdf")
        t.screenshot = "f"
      rescue => ex
        if ex.class == Capybara::Poltergeist::StatusFailError
          raise Manki::Error::HostNotFound, "Host '#{full_uri.host}' not found."
        else
          raise ex
        end
      end

      @history << full_uri.to_s

      t.stop!

      a.stop!({
        current_uri: current_uri,
        code: code
      })

      @session.actions << a

      return t
    end

    def find css: nil
      capybara_element = @capybara_window.session.find css
      Manki::Element.new capybara_element
    end

    def click opts
      window.click opts
    end

    def eval js
      window.eval js
    end

    def click css: nil
      element = find css: nil
      element.click
    end

    def eval js
      result = @capybara_window.session.evaluate_script js
    end

    def back
      @capybara_window.session.go_back
    end

    def forward
      @capybara_window.session.go_back
    end
  end

  include Methods
  include Attributes

  attr_reader :name



  def __capybara_window; @capybara_window; end

  def represents? capybara_window
    @capybara_window == capybara_window
  end

  def size
    @capybara_window.size
  end

  def resize(width,height)
    @capybara_window.resize_to width,height
  end

  def activate!
    @capybara_window.session.switch_to_window @capybara_window
  end

  def close
    @capybara_window.close
  end
end
