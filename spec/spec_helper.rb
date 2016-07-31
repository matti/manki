$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'byebug'
require 'autotest'

require './support/startserver'

RSpec.configure do |c|
  c.fail_fast = true
end

require 'manki'
