# poly_json

## syntax

Ref:
- https://www.json.org/json-en.html
- http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf

```
object =
  [ '{' ws '}' ]
  [ '{' members '}' ]

members =
  [ member ]
  [ member ',' members ]

member =
  [ ws string ws ':' element ]

array =
  [ '[' ws ']' ]
  [ '[' elements ']' ]

elements =
  [ element ]
  [ element ',' elements ]

element =
  [ ws value ws ]

string =
  [ '"' characters '"' ]

characters =
  ""
  [ character characters ]

character =
  [ '0020' . '10FFFF' - '"' - '\' ]
  [ '\' escape ]

escape =
  [ '"' ] # quotation mark
  [ '\' ] # reverse solidus
  [ '/' ] # solidus
  [ 'b' ] # backspace
  [ 'f' ] # form feed
  [ 'n' ] # line feed
  [ 'r' ] # carriage return
  [ 't' ] # caracter tabulation
  [ 'u' hex hex hex hex ] # unicode character

hax =
  [ digit ]
  [ 'A' . 'F' ]
  [ 'a' . 'f' ]

number =
  [ integer fraction exponent ]

integer =
  [ digit ]
  [ onenine digits ]
  [ '-' digit ]
  [ '-' onenine digit ]

digits =
  [ digit ]
  [ digit digits ]

digit =
  [ '0' ]
  [ onenine ]

onenine =
  [ '1' . '9' ]

fraction =
  ""
  [ '.' digits ]

exponent =
  ""
  [ 'E' sign digits ]
  [ 'e' sign digits ]

sign =
  ""
  [ '+' ]
  [ '-' ]

ws =
  ""
  ['0020' ws] # " "
  ['000A' ws] # "\n"
  ['000D' ws] # "\r"
  ['0009' ws] # "\t"
```
