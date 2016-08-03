class Manki::Action::Before < Manki::Action::Base
  def start!
    raise if @time
    @time = Time.now.utc
  end
end
