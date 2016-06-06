$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'kommando'
k = Kommando.new "ruby support/mankiserver.rb", {
  output: "log/mankiserver.log"
}
Thread.new do
  k.run
end

require 'manki'
