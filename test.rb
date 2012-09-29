
require_relative 'parser'
require_relative 'transformer'
require_relative 'renderer'
require 'pp'

less = "@offset: 10;
@var: rgb( 100 , 4 , 255 ) -5+@offset;
#footer {
  color: @var;
}"

p = MESS::Parser.new.parse(less)
t = MESS::Transformer.new.transform(p)
pp t
r = MESS::Renderer.new.render(t)

puts ""
puts r
