require './lib/manki'

m = Manki.new({
  host: "http://www.example.com"
})

m.get "/"
puts m.html
