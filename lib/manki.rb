require 'capybara'
require 'capybara/dsl'

require 'capybara/poltergeist'

require_relative "manki/version"

class Manki
  include Capybara::DSL

  def initialize(opts)
    Capybara.app_host = opts[:host]
    Capybara.current_driver = :poltergeist
    Capybara.reset_session!

    @performed = false
  end

  def get(path)
    visit path
    @performed = true
  end

  def html
    return nil unless @performed
    page.html
  end
end
