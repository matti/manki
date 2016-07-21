require './lib/manki'
require './support/startserver.rb'

m1 = Manki.new driver: :selenium
m2 = Manki.new

m1.location "http://localhost:4567"
m2.location "http://localhost:4567"
m2.location "/other.html"

puts m1.html
other_link = m1.find css: "a"
other_link.click
m1.location "/"
m1.click css: "a"

puts "--"
puts m2.html

sleep 999
