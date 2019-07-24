#!/usr/bin/env perl6

grammar LoniGrammar {
    rule TOP {
        [
            | \s+ | \n+ | \t+
            | <.comment>
            | <statement>
        ]*
    }

    rule statement {
        | <field-decl>
        | <type-decl>
    }

    proto rule type {*}

    rule type:sym<type> {
        | [ <ident> <type-struct:sym<type>> ]
        | <ident>
        | <type-struct:sym<type>>
        | <sequence>
    }
    rule type:sym<enum> {
        'Enum' <type-struct:sym<enum>>
    }

    rule type-decl { <ident> '=' <type> }

    proto rule type-struct {*}

    rule type-struct:sym<type> { '{' [ <field-decl> ',' ]* <field-decl> '}' }
    rule type-struct:sym<enum> { '{' [ [ <key> | <field-attr:sym<integer>> ] ',' ]* [ <key> | <field-attr:sym<integer>> ] '}' }

    rule sequence { '[' <type> ']' }

    rule field-decl { <field-mod>? <key> '=' <type> [ ':' <value> ]? }

    proto rule field-attr {*}

    rule field-attr:sym<any> { <key> ':' <value> }
    rule field-attr:sym<integer> { <key> ':' <value:sym<integer>> }

    proto token value {*}

    token value:sym<integer> { <digit>+ }

    proto token field-mod {*}

    token field-mod:sym<option> { '~' }
    token field-mod:sym<require> { '!' }

    proto token key {*}

    token key:sym<double-quote> { '"' <-[\"]>* '"' }
    token key:sym<single-quote> { "'" <-[\']>* "'" }

    token comment { '#'\N* }
}

# say LoniGrammar.parse('     Action =
# [Data{"key"= Status :2,
# "other"= None}] Status=[Enum{"zero":0, \'first\'}] Type=Null
# "hello"=Action
# # kkkk # dfkals
# #
# ');

say LoniGrammar.parse('
Status= Enum{
  "ok": 0,
  "fail": 1
}
')
