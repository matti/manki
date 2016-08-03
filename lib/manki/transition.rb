class Manki::Transition
  attr_reader :uri, :code
  attr_reader :started_at, :stopped_at
  attr_reader :screenshot

  def screenshot=(path)
    raise if @screenshot
    @screenshot = path
  end

  def performed?
    @performed
  end

  def uri=(u)
    raise "has uri" if @uri
    @uri = u
  end

  def performed=(p)
    raise "has performed" if @performed
    @performed = (p == true)
  end

  def code=(code)
    raise "has code" if @code
    @code = code
  end

  def start!
    raise "already started" if @started_at
    @started_at = Time.now.utc
  end

  def stop!
    raise "already stopped" if @stopped_at
    @stopped_at = Time.now.utc
  end

  def duration
    raise "not stopped" unless @stopped_at
    @stopped_at - @started_at
  end
end
