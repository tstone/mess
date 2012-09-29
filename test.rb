
require_relative 'parser'
require_relative 'transformer'
require_relative 'renderer'
require 'pp'

less = "
@offset: 10px;
@color: #ff0000;
@lesser_color: @color - 100;

#footer {
  color: @lesser_color;
  font-family: Arial;
  line-height: @offset
}"


p = MESS::Parser.new.parse(less)
pp p
puts "\n\n\n"

t = MESS::Transformer.new.transform(p)
r = MESS::Renderer.new.render(t)
puts r
