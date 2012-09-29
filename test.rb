
require_relative 'parser'
require_relative 'transformer'
require_relative 'translator'
require 'pp'

less = "@offset: 10;
@var: rgb( 100 , 4 , 255 ) -5+@offset;
#footer {
  color: @var;
}"

p = MESS::Parser.new.parse(less)
t = MESS::Transformer.new.transform(p)
l = MESS::Translator.new.translate(t)
pp l
