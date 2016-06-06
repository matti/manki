require 'kommando'
k = Kommando.new "ruby support/mankiserver.rb", {
  output: "log/mankiserver.log"
}
Thread.new do
  k.run
end
