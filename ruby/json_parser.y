class JsonParser
  options no_result_var

rule
  json : element { val[0] }
  value : object { val[0] }
        | array { val[0] }
        | string { val[0] }
        | number { val[0] }
        | "true" { true }
        | "false" { false } | "null" { nil }
  object : '{' '}' { {} }
         | '{' members '}' { val[1] }
  members : member { val[0] }
          | member ',' members { val[0].merge(val[2]) }
  member : string ':' element { { val[0] => val[2] } }
  array : '[' ']' { [] }
        | '[' elements ']' { val[1] }
  elements : element { val[0] }
           | element ',' elements { [val[0], *val[2]] }
  element : value { val[0] }
  string : '"' characters '"' { val[1] }
         | '"' '"' { '' }
  number : integer fraction exponent { (val[0] + val[1] + val[2]).to_f }
         | integer fraction { (val[0] + val[1]).to_f }
         | integer exponent { (val[0] + val[1]).to_f }
         | integer { val[0].to_i }
  integer : digit { val[0] }
          | onenine digits { val[0] + val[1] }
          | '-' digit { val[0] + val[1] }
          | '-' onenine_digits { val[0] + val[1] }
  digits : '0' { val[0] }
         | digit digits { val[0] + val[1] }
  digit : '0' { val[0] }
        | onenine { val[0] }
  fraction : '.' digits { val[0] + val[1] }
  exponent : 'E' sign digits { val[0] + val[1] + val[2] }
           | 'E' digits { val[0] + val[1] }
           | 'e' sign digits { val[0] + val[1] + val[2] }
           | 'e' digits { val[0] + val[1] }
  sign : '+' { val[0] }
       | '-' { val[0] }
end

---- inner

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

---- footer

if $0 == __FILE__
  test_str = '{ "str": "str\u0020str" }'
  pp JsonParser.new.parse(test_str)
end
