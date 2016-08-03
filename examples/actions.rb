require "./support/startserver"

require "./lib/manki"
require "byebug"
require "pp"

m = Manki.new


m.location "http://localhost:4567/"
m.location "/other.html"
m.location "/404"
m.location "/sleep/1"
m.location "/"

m.actions.each do |a|
  if a.class == Manki::Action::Location
    puts "#{a.before.uri} [#{a.before.code}] -> #{a.after.uri} [#{a.after.code}] (#{a.duration}s)"
  else
    raise "Unknown class"
  end
end
