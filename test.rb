
require_relative 'parser'
require_relative 'transformer'
require_relative 'renderer'
require 'pp'

less = "@the-border: 1px;
@base-color: #111;
@red:        #842210;

#header {
  color: @base-color * 3;
  border-left: @the-border;
  border-right: @the-border * 2;
}
#footer {
  color: @base-color + #003300;
  border-color: desaturate(@red, 10%);
}"


p = MESS::Parser.new.parse(less)
pp p
puts "\n\n\n"

t = MESS::Transformer.new.transform(p)
r = MESS::Renderer.new.render(t)
puts r
