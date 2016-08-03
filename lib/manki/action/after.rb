class Manki::Action::After < Manki::Action::Base

  def initialize(opts, success:)
    super opts
    @success = success
  end

  def stop!
    raise if @time
    @time = Time.now.utc
  end

  def sucess?
    @success
  end
end
