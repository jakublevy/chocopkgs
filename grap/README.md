

# grap
Typesets graphs to be processed by the pic command. 

The **grap** command processes grap language input files and generates input to the pic command. The grap language is a language for typesetting graphs. A typical command line is:
```
grap  File  |  pic  |  troff  |  Typesetter
```
Graphs are surrounded by the **.G1** and **.G2 troff** command requests. Data enclosed by these requests are scaled and plotted, with tick marks automatically supplied. Commands exist to modify the frame, add labels, override the default ticks, change the plotting style, define coordinate ranges and transformations, and include data from files. In addition, the grap command provides the same loops, conditionals, and macroprocessing as the pic command.

Grap language files contain grap programs. A grap program is written in the form:
```
.G1
grap Statement
grap Statement
grap Statement
.G2
```