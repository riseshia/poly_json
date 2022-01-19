class JsonParser
  options no_result_var

rule
  json : element { val[0] }
  value : object { val[0] }
        | array { val[0] }
        | string { val[0] }
        | number { val[0] }
        | "true" { true }
        | "false" { false }
        | "null" { nil }
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
         | '"' '"' { "" }
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

def parse(text)
  text = text.strip
  @tokens = []

  until text.empty?
    case text
    when /\A\s+/
      # do nothing
    when /\A[{}":.,]/
      s = $&
      @tokens.push [s, s]
    when /\A0/
      s = $&
      @tokens.push [s, s]
    when /\A[1-9]/
      s = $&
      @tokens.push [:onenine, s]
    when /\A\w+/
      s = $&
      @tokens.push [:characters, s]
    when /\A[+-]/
      s = $&
      @tokens.push [:sign, s]
    end

    text = $'
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
  test_str = '{ "aa": 1.0, "str": 10 }'
  pp JsonParser.new.parse(test_str)
end
