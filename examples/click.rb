require './lib/manki'
require './support/startserver.rb'

m = Manki.new {
  host: "http://localhost:4567"
}

m.get "/"
m.click "Go to other"
puts m.html
