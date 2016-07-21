require 'capybara'
require 'capybara/dsl'

require 'capybara/poltergeist'

require 'active_support/all'

require_relative "manki/version"
require_relative "manki/session"
require_relative "manki/window"
require_relative "manki/element"

class Manki
  def initialize(driver: :poltergeist)
    @session = Session.new driver: driver
  end

  def __session; @session; end

  def location l
    window.location l
  end

  def html
    window.html
  end

  def text
    window.text
  end

  def find opts
    window.find opts
  end

  def click opts
    window.click opts
  end

  def eval js
    window.eval js
  end

  def history
    window.history
  end

  def windows
    @session.windows
  end

  def window
    @session.active_window
  end
end
