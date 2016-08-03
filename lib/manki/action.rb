class Manki::Action
  class Location < Manki::Action; end

  require_relative "action/base"
  require_relative "action/before"
  require_relative "action/after"

  attr_reader :before, :after

  def initialize current_uri:, code:
    @before = Manki::Action::Before.new({
      uri: current_uri,
      code: code
    })
  end

  def start!
    @before.start!
  end

  def stop! current_uri:, code:, success:
    @after = Manki::Action::After.new({
      uri: current_uri,
      code: code,
    },{
      success: success
    })

    @after.stop!
  end

  def started_at
    @before.time
  end

  def stopped_at
    @after.time
  end

  def duration
    (stopped_at - started_at)
  end

  def success?
    @after.success?
  end
end
