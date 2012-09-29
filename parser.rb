require 'parslet'

module MESS
  class Parser < Parslet::Parser
    # Chars
    rule(:space)                { match('\s').repeat(1) }
    rule(:space?)               { space.maybe }
    rule(:at)                   { str('@') >> space? }
    rule(:comma)                { space? >> str(',') >> space? }
    rule(:comma?)               { comma.maybe }
    rule(:lbrace)               { str('{') >> space? }
    rule(:rbrace)               { str('}') >> space? }
    rule(:lparen)               { str('(') >> space? }
    rule(:rparen)               { str(')') >> space? }
    rule(:colon)                { str(':') >> space? }
    rule(:semicolon)            { str(';') >> space? }
    rule(:semicolon?)           { semicolon.maybe }
    rule(:operator)             { space? >> match('[+\-\\*]').as(:operator) >> space? }
    rule(:number)               { match['0-9'].repeat }
    rule(:hex_char)             { match('[0-9a-fA-F]') }

    # Built-in functions
    rule(:color_function)       { (str('lighten') | str('darken') | str('saturate') | str('desaturate') | str('fakein') | str('fakeout') | str('fade') | str('spin') | str('mix')).as(:builtin_func) >> space? }

    # Measurements
    rule(:percent)              { number >> str('%') >> space? }
    rule(:inch)                 { number >> str('in') >> space? }
    rule(:cm)                   { number >> str('cm') >> space? }
    rule(:mm)                   { number >> str('mm') >> space? }
    rule(:em)                   { number >> str('em') >> space? }
    rule(:ex)                   { number >> str('ex') >> space? }
    rule(:pt)                   { number >> str('pt') >> space? }
    rule(:pc)                   { number >> str('pc') >> space? }
    rule(:px)                   { number >> str('px') >> space? }
    rule(:measurement)          { percent | inch | cm | mm | em | ex | pt | pc | px }

    # Colors
    rule(:hex_color)            { (str('#') >> (hex_char.repeat(3) | hex_char.repeat(6))).as(:hex_color) >> space? }
    rule(:rgb_color)            { (str('rgb(') >> space? >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> space? >> rparen).as(:rgb_color) >> space? }
    rule(:rgba_color)           { (str('rgba(') >> space? >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> space? >>  rparen).as(:rgba_color) >> space? }
    rule(:hsl_color)            { (str('hsl(') >> space? >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> space? >> rparen).as(:hsl_color) >> space? }
    rule(:hsla_color)           { (str('hsla(') >> space? >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> comma >> number.repeat(1,3) >> space? >>  rparen).as(:hsla_color) >> space? }
    rule(:color)                { (hex_color | rgb_color | rgba_color | hsl_color | hsla_color).as(:color) }

    # Values/Variables
    rule(:variable)             { at >> match('[\w\-]').repeat(1).as(:var) }
    rule(:simple_value)         { match['^;'].repeat(1) }
    rule(:simple_arg_value)    { match['^,)'].repeat(1) }
    rule(:value)                { variable | simple_value }
    rule(:operator_expression)  { (operator >> (variable | number).as(:right_hand)).as(:operation).repeat >> space? }
    rule(:with_op)              { ((color | measurement | variable) >> operator_expression).as(:expression) }
    rule(:function_call)        { (color_function >> arg_call_list).as(:expression) }
    rule(:value_var_expr)       { with_op | function_call | simple_arg_value }

    # Things
    rule(:selector)             { match('[a-z0-9&:#*-.="\[\]]').repeat(1).as(:selector) >> space? }
    rule(:property)             { match('[a-z0-9-]').repeat(1).as(:property) >> space? }
    rule(:block)                { lbrace >> block_content.repeat.as(:block) >> rbrace }
    rule(:arg)                  { variable.as(:arg) >> arg_val.maybe }
    rule(:arg_val)              { colon >> match('[^,)]').repeat(1).as(:arg_val) }
    rule(:arg_def_list)         { lparen >> (arg >> comma?).repeat(0).as(:arglist) >> rparen }
    rule(:arg_call_list)        { lparen >> (value_var_expr >> comma?).repeat(0).as(:parameters) >> rparen }
    rule(:mixin_inc)            { selector.as(:mixin) >> arg_call_list.maybe >> semicolon }

    # Grammar
    rule(:variable_definition)  { variable >> colon >> value_var_expr >> semicolon? }
    rule(:property_definition)  { property >> colon >> value_var_expr >> semicolon? }
    rule(:style_declaration)    { selector >> block }
    rule(:mixin_definition)     { selector >> arg_def_list >> block }
    rule(:snippet)              { variable_definition.as(:var_def) | mixin_definition.as(:mixin_def) | style_declaration.as(:style_dec) }
    rule(:block_content)        { snippet | property_definition.as(:prop_def) | mixin_inc.as(:mixin_inc) }
    rule(:document)             { space? >> snippet.repeat }

    root :document
  end
end
