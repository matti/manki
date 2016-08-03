class Manki::Action::Base
  attr_reader :uri, :time, :code

  def initialize uri:, code:
    @uri = uri
    @code = code
  end

end
