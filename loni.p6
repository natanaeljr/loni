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

    rule type-struct:sym<enum> { '{' [ <field-attr> ',' ]* <field-attr> '}' }

    rule field-decl { <field-mod>? <key> '=' <type> [ ':' <value> ]? }

    rule field-attr { <key> [ ':' <value> ]? }

    rule field-mod { '~' | '!' }

    rule value { <digit>+ }

    rule sequence { '[' <type> ']' }

    token key { \" <-[\"]>* \" }

    token comment { '#'\N* }

    # token ws { \s* | \t* }
}

say LoniGrammar.parse('     Action =
[Data{"key"= Status :2,
"other"= None}] Status=[Enum{"zero":0, "first":1}] Type=Null
"hello"=Action
# kkkk # dfkals
#
');

