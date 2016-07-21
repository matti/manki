class Manki::Window

  attr_reader :name

  def initialize(capybara_window, name:)
    @capybara_window = capybara_window
    @name = name

    @history = []
  end

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

  def location uri_or_partial_uri
    parsed_uri = URI.parse uri_or_partial_uri
    if parsed_uri.scheme == "http"
      Capybara.app_host = "#{parsed_uri.scheme}://#{parsed_uri.host}:#{parsed_uri.port}#{parsed_uri.path}"
    end

    @capybara_window.session.visit parsed_uri.path
    puts @history.inspect
    @history << 1 #@capybara_window.session.current_url
    puts @history.inspect

  end

  def html
    @capybara_window.session.html
  end

  def text
    @capybara_window.session.text
  end

  def find css: nil
    capybara_element = @capybara_window.session.find css
    Manki::Element.new capybara_element
  end

  def click css: nil
    element = find css: nil
    element.click
  end

  def eval js
    result = @capybara_window.session.evaluate_script js
  end

  def history
    @history
  end

  def back
    @capybara_window.session.go_back
  end

  def close
    @capybara_window.close
  end
end
