require 'parslet'

module MESS

  # Parser:
  # Turn a raw string into a series of hashes, arrays, and symbols
  class Parser < Parslet::Parser
    # Chars
    rule(:space)                { match('\s').repeat(1) }
    rule(:space?)               { space.maybe }
    rule(:at)                   { str('@') >> space? }
    rule(:comma)                { space? >> str(',') >> space? }
    rule(:comma?)               { comma.maybe }
    rule(:lbrace)               { space? >> str('{') >> space? }
    rule(:rbrace)               { space? >> str('}') >> space? }
    rule(:lparen)               { str('(') >> space? }
    rule(:rparen)               { str(')') >> space? }
    rule(:colon)                { str(':') >> space? }
    rule(:semicolon)            { str(';') >> space? }
    rule(:semicolon?)           { semicolon.maybe }
    rule(:operator)             { space? >> match('[+\-\\*]').as(:operator) >> space? }
    rule(:number)               { match['0-9'].repeat(1) }
    rule(:hex_char)             { match('[0-9a-fA-F]') }

    # Built-in functions
    rule(:color_function)       { (str('lighten') | str('darken') | str('saturate') | str('desaturate') | str('fakein') | str('fakeout') | str('fade') | str('spin') | str('mix')).as(:builtin_func) >> space? }

    # Measurements
    rule(:percent)              { number.as(:percent) >> str('%') >> space? }
    rule(:inch)                 { number.as(:in) >> str('in') >> space? }
    rule(:cm)                   { number.as(:cm) >> str('cm') >> space? }
    rule(:mm)                   { number.as(:mm) >> str('mm') >> space? }
    rule(:em)                   { number.as(:em) >> str('em') >> space? }
    rule(:ex)                   { number.as(:ex) >> str('ex') >> space? }
    rule(:pt)                   { number.as(:pt) >> str('pt') >> space? }
    rule(:pc)                   { number.as(:pc) >> str('pc') >> space? }
    rule(:px)                   { number.as(:px) >> str('px') >> space? }
    rule(:measurement)          { (percent | inch | cm | mm | em | ex | pt | pc | px).as(:measurement) }

    # Colors
    rule(:hex_color)            { (str('#') >> (hex_char.repeat(3) | hex_char.repeat(6))).as(:hex_color) >> space? }
    rule(:rgb_color)            { (str('rgb(') >> space? >> number.as(:r) >> comma >> number.as(:g) >> comma >> number.as(:b) >> space? >> rparen).as(:rgb_color) >> space? }
    rule(:rgba_color)           { (str('rgba(') >> space? >> number.as(:r) >> comma >> number.as(:g) >> comma >> number.as(:b) >> comma >> number.as(:a) >> space? >>  rparen).as(:rgba_color) >> space? }
    rule(:hsl_color)            { (str('hsl(') >> space? >> number.as(:h) >> comma >> number.as(:s) >> comma >> number.as(:l) >> space? >> rparen).as(:hsl_color) >> space? }
    rule(:hsla_color)           { (str('hsla(') >> space? >> number.as(:h) >> comma >> number.as(:s) >> comma >> number.as(:l) >> comma >> number.as(:a) >> space? >>  rparen).as(:hsla_color) >> space? }
    rule(:color)                { (hex_color | rgb_color | rgba_color | hsl_color | hsla_color).as(:color) }

    # Values/Variables
    rule(:variable)             { at >> match('[\w\-]').repeat(1).as(:var) }
    rule(:simple_value)         { match['^;'].repeat(1) }
    rule(:simple_arg_value)     { match['^,)'].repeat(1) }
    rule(:value)                { variable | simple_value }
    rule(:function_call)        { (color_function >> arg_call_list).as(:expression) }
    rule(:selector)             { match('[A-Za-z0-9&:#*-.="\[\]]').repeat(1).as(:selector) >> space? }
    rule(:property)             { match('[A-Za-z0-9-]').repeat(1).as(:property) >> space? }
    rule(:arg)                  { variable.as(:arg) >> (colon >> simple_arg_value.as(:arg_val)).maybe }

    # Expressions and Operations
    rule(:arg_operation)        { operator >> arg_expression.as(:right_hand) }
    rule(:value_operation)      { operator >> value_expression.as(:right_hand) }
    rule(:arg_expression)       { (function_call | variable | measurement | color | simple_arg_value) >> arg_operation.as(:operation).maybe }
    rule(:value_expression)     { (function_call | variable | measurement | color | simple_value) >> value_operation.as(:operation).maybe }

    # Grammar
    rule(:block)                { lbrace >> block_content.repeat.as(:block) >> rbrace }
    rule(:arg_def_list)         { lparen >> (arg >> comma?).repeat(0).as(:arglist) >> rparen }
    rule(:arg_call_list)        { lparen >> (arg_expression >> comma?).repeat(0).as(:parameters) >> rparen }
    rule(:mixin_inc)            { selector.as(:mixin) >> (arg_call_list.maybe >> semicolon? | semicolon) }
    rule(:value_definition)     { colon >> value_expression.as(:expression) >> semicolon? }
    rule(:variable_definition)  { variable >> value_definition }
    rule(:property_definition)  { property >> value_definition }
    rule(:style_declaration)    { selector >> block }
    rule(:mixin_definition)     { selector >> arg_def_list >> block }
    rule(:snippet)              { variable_definition.as(:var_def) | mixin_definition.as(:mixin_def) | style_declaration.as(:style_dec) }
    rule(:block_content)        { snippet | property_definition.as(:prop_def) | mixin_inc.as(:mixin_inc) }
    rule(:document)             { space? >> snippet.repeat }

    root :document
  end
end
