require 'kommando'
k = Kommando.run_async "ruby support/mankiserver.rb", {
  output: "log/mankiserver.log"
}
