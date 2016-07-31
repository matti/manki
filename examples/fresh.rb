require "./support/startserver"

require "./lib/manki"
require "byebug"
require "pp"

manki_a = Manki.new
manki_b = Manki.new

transition = manki_a.location "http://localhost:4567/sleep/0"
puts "code: #{transition.code}"
puts "performed?: #{transition.performed?}"

puts "started: #{transition.started_at}"
puts "stopped: #{transition.stopped_at}"
puts "duration: #{transition.duration}"

slow_transition = manki_a.location "http://localhost:4567/sleep/1.5"
puts "slow duration: #{slow_transition.duration}"
raise if slow_transition.duration < 1.5

begin
  manki_b.location "/"
rescue Manki::Error::Navigation => ex
end
