
require_relative 'parser'
require_relative 'transformer'
require_relative 'renderer'
require 'pp'

less = "
@color: #ff0000;
@offset: 10;
@var: rgb( 100 , 4 , 255 ) -5+@offset;

#footer {
  color: @color;
  font-family: Arial;
  line-height: @offset
}"


p = MESS::Parser.new.parse(less)
pp p
puts "\n\n"

t = MESS::Transformer.new.transform(p)
pp t
puts "\n\n"

r = MESS::Renderer.new.render(t)
puts r
