class Manki::Session
  def initialize(driver:)
    @window_sequence = -1
    @capybara_windows = {}

    Capybara.current_driver = driver #TODO: race
    Capybara.session_name = SecureRandom::uuid #TODO: race
    #TODO: race?
    @capybara_session = Capybara.current_session # registers to session_pool and returns
    # session_pool["#{current_driver}:#{session_name}:#{app.object_id}"] ||= Capybara::Session.new(current_driver, app)
  end

  def __capybara_session; @capybara_session; end

  def windows
    @capybara_windows.delete_if do |capybara_window, window|
      !@capybara_session.windows.include? capybara_window
    end

    @capybara_session.windows.each do |capybara_window|
      @capybara_windows[capybara_window] ||= Manki::Window.new capybara_window, name: (@window_sequence += 1).to_s
    end

    windows_by_name = {}
    @capybara_windows.each_pair do |capybara_window, window|
      windows_by_name[window.name] = window
    end

    session = self
    windows_by_name.define_singleton_method(:open) do |opts={}|
        session.window_open
    end

    windows_by_name
  end

  def active_window
    windows

    @capybara_windows[@capybara_session.current_window]
  end

  def open_new_window
    capybara_window = @capybara_session.open_new_window
    @capybara_windows[capybara_window] = Manki::Window.new capybara_window, {
      name: (@window_sequence += 1).to_s
    }
  end
end
