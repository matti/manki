class Manki::Element
  def initialize(capybara_element)
    @capybara_element = capybara_element
  end

  def __capybara_element; @capybara_element; end

  def text
    @capybara_element.text
  end

  def visible?
    @capybara_element.visible?
  end

  def xpath
    @capybara_element.path
  end

  def click
    #TODO .right_click, double_click
    @capybara_element.click
  end

  def position
    pos = @capybara_element.hover
    [pos['position']['x'], pos['position']['y']] #dig
  end

  def hover
    @capybara_element.hover
  end

  # def drag_to(element)
  #   @capybara_element
  # end



end
