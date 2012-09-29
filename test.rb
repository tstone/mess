
require_relative 'parser'
require_relative 'transformer'
require 'pp'

less = "#footer {
  color: #003300;
}"

less = "@var: 5-5"

p = MESS::Parser.new.parse(less)
pp p
#t = MESS::Transformer.new.transform(p)
# puts MESS::Transformer.new.transform(p)
#pp t