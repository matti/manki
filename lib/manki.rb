require 'capybara'
require 'capybara/dsl'

require 'capybara/poltergeist'

require_relative "manki/version"

class Manki
  module Mankibara
    extend Capybara::DSL
  end

  def initialize(opts)
    Capybara.app_host = opts[:host]
    Capybara.current_driver = :poltergeist
    Capybara.reset_session!

    @performed = false
  end

  def get(path)
    Mankibara.visit path
    @performed = true
  end

  def click(what)
    Mankibara.click_on what
  end

  def html
    return nil unless @performed
    Mankibara.page.html
  end
end
