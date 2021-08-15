# vlna
Program vlna adds ties (Czech vlna or vlnka) after nonsyllabic prepositions (instead of spaces) in the TeX source files. This prevents line breaks at undesirable spaces.

## Preface
There exists a special Czech and Slovak typographical rule: you cannot leave the non-syllabic preposition on the end of one line and continue writing text on next line. For example, you cannot write down the text "v lese" (in a forest) like "v[new-line]lese". The program vlna adds the ASCII tilde between such preposition and the next word and removes the space(s) in this place. It means the program converts "v lese" to "v~lese". You can use this program as a preprocessor before TeXing. Moreover, you can set another sequence to store instead ASCII tilde (see the -x option).