require 'capybara'
require 'capybara/dsl'

require 'capybara/poltergeist'

require 'active_support/all'

require_relative "manki/version"
require_relative "manki/session"
require_relative "manki/window"
require_relative "manki/transition"
require_relative "manki/element"
require_relative "manki/action"

class Manki
  module Error
    class Base < StandardError; end
    class Navigation < Base; end
    class SchemeNotSupported < Base; end
    class HostNotFound < Base; end
  end

  def initialize(driver: :poltergeist)
    @session = Session.new driver: driver
  end

  def actions; @session.actions; end
  def windows; @session.windows; end
  def window; @session.active_window; end
  def html; window.html; end
  def text; window.text; end
  def __session; @session; end

  def location uri_or_partial_uri
    window.location uri_or_partial_uri
  end
end
