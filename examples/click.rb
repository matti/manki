require './lib/manki'
require './support/startserver.rb'

m = Manki.new

m.location "http://localhost:4567/"
link = m.find(css: "a").find(text: "Go to other")
link.click
