
require_relative 'parser'
require_relative 'transformer'
require_relative 'renderer'
require 'pp'

less = "@red: #8c0000;

h2 {
    color: @red - 100;
}"


p = MESS::Parser.new.parse(less)
pp p
puts "\n\n\n"

t = MESS::Transformer.new.transform(p)
r = MESS::Renderer.new.render(t)
puts r
