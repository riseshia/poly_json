#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.6.0
# from Racc grammar file "".
#

require 'racc/parser.rb'
class JsonParser < Racc::Parser

module_eval(<<'...end json_parser.y/module_eval...', 'json_parser.y', 46)

ESCAPE_CHARACTER = %w(" \\ / b f n r t u)

def sub_escape_char(chr)
  case chr
  when '"' then '"'
  when '\\' then '\\'
  when 'b' then "\b"
  when 'f' then "\f"
  when 'n' then "\n"
  when 'r' then "\r"
  when 't' then "\t"
  else
    raise "#{chr} is not valid escape character."
  end
end

def sub_unicode_hex(hex)
  [hex.to_i(16)].pack("U*")
end

def parse(text)
  text = text.strip
  @tokens = []

  until text.empty?
    case text
    when /\A\s+/
      # do nothing
      text = $'
    when /\A[{}:.,]/
      s = $&
      @tokens.push [s, s]
      text = $'
    when /\A0/
      s = $&
      @tokens.push [s, s]
      text = $'
    when /\A[1-9]/
      s = $&
      @tokens.push [:onenine, s]
      text = $'
    when /\A"/ # be string
      @tokens.push ['"', '"']
      chars = ''
      i = 1

      loop do
        break if text[i] == '"'
        if !text[i].match?(/[\u{0020}-\u{10FFFF}]/)
          raise "#{text[i]} is invalid character."
        end

        if text[i] == '\\'
          if text[i + 1] == 'u'
            if text[(i + 2)..(i + 5)].match?(/\A[0-9A-Fa-f]{4}\z/)
              chars += sub_unicode_hex(text[(i + 2)..(i + 5)])
              i += 6
            else
              raise "\\u#{text[(i + 2)..(i + 5)]} is not valid unicode!!!"
            end
          else
            chars += sub_escape_char(text[i + 1])
            i += 2
          end
        else
          chars += text[i]
          i += 1
        end
      end

      @tokens.push [:characters, chars]
      @tokens.push ['"', '"']
      text = text[(i+1)..]
    when /\A[+-]/
      s = $&
      @tokens.push [:sign, s]
      text = $'
    end
  end

  do_parse
end

def next_token
  @tokens.shift
end

def on_error(*args)
  puts "parse fail"
  pp args
end

...end json_parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
     7,     8,     9,    10,    19,    20,    40,    11,    41,    13,
    13,    16,    17,    42,    18,     7,     8,     9,    10,    31,
    32,    33,    11,    24,    13,    37,    16,    17,    35,    18,
     7,     8,     9,    10,    43,    37,    44,    11,    35,    13,
   -31,    16,    17,   -31,    18,     7,     8,     9,    10,    45,
    37,    46,    11,    35,    13,    37,    16,    17,    35,    18,
    37,    52,    13,    35,   nil,    37,    52,    51,    35,    28,
    27,    37,    51,    39,    18,    37,    32,    33,    35 ]

racc_action_check = [
     0,     0,     0,     0,     1,    10,    19,     0,    21,     0,
    10,     0,     0,    22,     0,    11,    11,    11,    11,    14,
    14,    14,    11,    11,    11,    16,    11,    11,    16,    11,
    43,    43,    43,    43,    23,    31,    25,    43,    31,    43,
    35,    43,    43,    35,    43,    45,    45,    45,    45,    26,
    36,    27,    45,    36,    45,    49,    45,    45,    49,    45,
    32,    32,    42,    32,   nil,    33,    33,    32,    33,    13,
    13,    17,    33,    17,    17,    53,    29,    29,    53 ]

racc_action_pointer = [
    -2,     4,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    -1,    13,   nil,    58,     2,   nil,    12,    58,   nil,     6,
   nil,     2,     6,    26,   nil,    26,    42,    40,   nil,    58,
   nil,    22,    47,    52,   nil,    27,    37,   nil,   nil,   nil,
   nil,   nil,    51,    28,   nil,    43,   nil,   nil,   nil,    42,
   nil,   nil,   nil,    62,   nil,   nil,   nil,   nil,   nil,   nil,
   nil ]

racc_action_default = [
   -40,   -40,    -1,    -2,    -3,    -4,    -5,    -6,    -7,    -8,
   -40,   -40,   -18,   -40,   -24,   -25,   -32,   -40,   -31,   -40,
    -9,   -40,   -11,   -40,   -14,   -40,   -16,   -40,   -20,   -22,
   -23,   -40,   -40,   -40,   -26,   -29,   -40,   -32,   -27,   -28,
    61,   -10,   -40,   -40,   -15,   -40,   -19,   -21,   -33,   -40,
   -35,   -38,   -39,   -40,   -37,   -30,   -12,   -13,   -17,   -34,
   -36 ]

racc_goto_table = [
    15,     2,    23,    34,    25,    21,    30,    49,    53,     1,
    29,    15,   nil,   nil,   nil,   nil,   nil,    38,    48,    50,
    54,    47,   nil,    55,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    23,   nil,    59,    56,    58,   nil,
    60,   nil,   nil,    15,    57,    15 ]

racc_goto_check = [
    14,     2,     6,    15,    10,     8,    13,    16,    16,     1,
    12,    14,   nil,   nil,   nil,   nil,   nil,    14,    15,    15,
    15,    13,   nil,    15,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,     6,   nil,    15,     8,    10,   nil,
    15,   nil,   nil,    14,     2,    14 ]

racc_goto_pointer = [
   nil,     9,     1,   nil,   nil,   nil,    -8,   nil,    -5,   nil,
    -7,   nil,    -4,    -8,     0,   -13,   -25 ]

racc_goto_default = [
   nil,   nil,    26,    12,     3,     4,     5,     6,   nil,    22,
   nil,    14,   nil,   nil,    36,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 22, :_reduce_1,
  1, 24, :_reduce_2,
  1, 24, :_reduce_3,
  1, 24, :_reduce_4,
  1, 24, :_reduce_5,
  1, 24, :_reduce_6,
  1, 24, :_reduce_7,
  1, 24, :_reduce_8,
  2, 25, :_reduce_9,
  3, 25, :_reduce_10,
  1, 29, :_reduce_11,
  3, 29, :_reduce_12,
  3, 30, :_reduce_13,
  2, 26, :_reduce_14,
  3, 26, :_reduce_15,
  1, 31, :_reduce_16,
  3, 31, :_reduce_17,
  1, 23, :_reduce_18,
  3, 27, :_reduce_19,
  2, 27, :_reduce_20,
  3, 28, :_reduce_21,
  2, 28, :_reduce_22,
  2, 28, :_reduce_23,
  1, 28, :_reduce_24,
  1, 32, :_reduce_25,
  2, 32, :_reduce_26,
  2, 32, :_reduce_27,
  2, 32, :_reduce_28,
  1, 36, :_reduce_29,
  2, 36, :_reduce_30,
  1, 35, :_reduce_31,
  1, 35, :_reduce_32,
  2, 33, :_reduce_33,
  3, 34, :_reduce_34,
  2, 34, :_reduce_35,
  3, 34, :_reduce_36,
  2, 34, :_reduce_37,
  1, 37, :_reduce_38,
  1, 37, :_reduce_39 ]

racc_reduce_n = 40

racc_shift_n = 61

racc_token_table = {
  false => 0,
  :error => 1,
  "true" => 2,
  "false" => 3,
  "null" => 4,
  "{" => 5,
  "}" => 6,
  "," => 7,
  ":" => 8,
  "[" => 9,
  "]" => 10,
  "\"" => 11,
  :characters => 12,
  :onenine => 13,
  "-" => 14,
  :onenine_digits => 15,
  "0" => 16,
  "." => 17,
  "E" => 18,
  "e" => 19,
  "+" => 20 }

racc_nt_base = 21

racc_use_result_var = false

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "\"true\"",
  "\"false\"",
  "\"null\"",
  "\"{\"",
  "\"}\"",
  "\",\"",
  "\":\"",
  "\"[\"",
  "\"]\"",
  "\"\\\"\"",
  "characters",
  "onenine",
  "\"-\"",
  "onenine_digits",
  "\"0\"",
  "\".\"",
  "\"E\"",
  "\"e\"",
  "\"+\"",
  "$start",
  "json",
  "element",
  "value",
  "object",
  "array",
  "string",
  "number",
  "members",
  "member",
  "elements",
  "integer",
  "fraction",
  "exponent",
  "digit",
  "digits",
  "sign" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'json_parser.y', 4)
  def _reduce_1(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 5)
  def _reduce_2(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 6)
  def _reduce_3(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 7)
  def _reduce_4(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 8)
  def _reduce_5(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 9)
  def _reduce_6(val, _values)
     true
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 10)
  def _reduce_7(val, _values)
     false
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 10)
  def _reduce_8(val, _values)
     nil
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 11)
  def _reduce_9(val, _values)
     {}
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 12)
  def _reduce_10(val, _values)
     val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 13)
  def _reduce_11(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 14)
  def _reduce_12(val, _values)
     val[0].merge(val[2])
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 15)
  def _reduce_13(val, _values)
     { val[0] => val[2] }
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 16)
  def _reduce_14(val, _values)
     []
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 17)
  def _reduce_15(val, _values)
     val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 18)
  def _reduce_16(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 19)
  def _reduce_17(val, _values)
     [val[0], *val[2]]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 20)
  def _reduce_18(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 21)
  def _reduce_19(val, _values)
     val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 22)
  def _reduce_20(val, _values)
     ''
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 23)
  def _reduce_21(val, _values)
     (val[0] + val[1] + val[2]).to_f
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 24)
  def _reduce_22(val, _values)
     (val[0] + val[1]).to_f
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 25)
  def _reduce_23(val, _values)
     (val[0] + val[1]).to_f
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 26)
  def _reduce_24(val, _values)
     val[0].to_i
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 27)
  def _reduce_25(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 28)
  def _reduce_26(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 29)
  def _reduce_27(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 30)
  def _reduce_28(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 31)
  def _reduce_29(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 32)
  def _reduce_30(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 33)
  def _reduce_31(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 34)
  def _reduce_32(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 35)
  def _reduce_33(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 36)
  def _reduce_34(val, _values)
     val[0] + val[1] + val[2]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 37)
  def _reduce_35(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 38)
  def _reduce_36(val, _values)
     val[0] + val[1] + val[2]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 39)
  def _reduce_37(val, _values)
     val[0] + val[1]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 40)
  def _reduce_38(val, _values)
     val[0]
  end
.,.,

module_eval(<<'.,.,', 'json_parser.y', 41)
  def _reduce_39(val, _values)
     val[0]
  end
.,.,

def _reduce_none(val, _values)
  val[0]
end

end   # class JsonParser


if $0 == __FILE__
  test_str = '{ "str": "str\u0020str" }'
  pp JsonParser.new.parse(test_str)
end
