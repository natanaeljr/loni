#!/usr/bin/env perl6

grammar LoniGrammar {
    rule TOP { <statement>+ .* }
    rule statement { [ <type-declaration> ] }
    rule type-declaration { <identifier> '=' <type> }
    token identifier { \w+ }
    token type { <identifier>? }
}

say LoniGrammar.parse("Action = Enum");

# grammar G {
#     token TOP { <thingy> .* }
#     token thingy { 'Por' }
# }
 
# my $match = G.parse("Por is mighty");
# say $match;
