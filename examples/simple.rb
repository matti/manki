require './lib/manki'
require './support/startserver'

m = Manki.new

m.location "http://localhost:4567"
puts m.html
