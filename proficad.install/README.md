**NOTE:** The following text is for the most part an excerpt from [the official website](https://www.proficad.com).

# ProfiCAD
ProfiCAD is designed for drawing of [electrical and electronic diagrams](https://www.proficad.com/screenshots.aspx), schematics, control circuit diagrams and can also be used for pneumatics, hydraulics and other types of technical diagrams. 

The easiest CAD for electrical circuits. Maximum care was paid to ergonomics and ease of use. Just [place electrical symbols](https://www.proficad.com/help/de/how-to-insert-symbols.htm) into the drawing and [attach the wires](https://www.proficad.com/help/de/how-to-draw-electrical-wires.htm). 

Ships with more than one thousand [symbols](https://gallery.proficad.com/Symbols/). You can easily create your own symbols in the [symbol editor](https://www.proficad.com/help/pe/drawing-electrical-symbols.htm) or have them drawn for you for a fee. 

Supports automatic numbering of symbols, generation of netlists, [lists of wires](https://www.proficad.com/help/reports/list-of-wires.htm), [bills of material](https://www.proficad.com/help/reports/bill-of-material.htm), drawing of [striped wires](https://www.proficad.com/help/de/how-to-draw-electrical-wires.htm) and further advanced features. 

The program supports [cross references](https://www.proficad.com/help/de/cross-references.htm) between wires and between symbols belonging to one component (e.g. relay coil + contacts). A linked symbol on a different page can be accessed by clicking on the cross reference. 

Modern programming architecture + advanced optimizations = low demands on CPU, disk space and [the budget](https://www.proficad.com/purchase.aspx).
**System requirements**: Windows XP+SP3, Vista, Windows 7 - 10, .NET4, 15 MB of disk space. 

The title block designed in accordance with ISO 7200 can be easily adapted, for example by inserting the logo of your company. Or you can [create your own](https://www.proficad.com/help/tb/how-to-create-title-block.htm) in the title block editor. 

The program was translated into [many languages](https://gallery.proficad.com/pages/translate.aspx)​​, which will facilitate cooperation with international partners. Drawings can be [exported into the DXF](https://www.proficad.com/help/reports/export-dxf.htm) format. 

The non-commercial (home) edition is distributed [free of charge](https://www.proficad.com/download.aspx) and has [some limitations](https://www.proficad.com/Editions.aspx): it does not support the bill of material, netlist, list of wires, reference grid, title block editor and some other limitations. 

## Parameters
* `/InstallationPath:` - where to install the binaries
    - Default value: 
        - `"${env:ProgramFiles(x86)}\ProfiCAD"` on 64-bit Windows
        - `"$env:ProgramFiles\ProfiCAD"` on 32-bit Windows

### Examples
* Install into `D:\ProfiCAD` directory
    ```
    choco install proficad --params "/InstallationPath:D:\ProfiCAD"
    ```