**NOTE:** The following text is for the most part an excerpt from the official [README.md](https://github.com/ciromattia/kcc/blob/master/README.md).

# Kindle Comic Converter
Kindle Comic Converter (KCC) is a Python app to convert comic/manga files to EPUB, Panel View MOBI or E-Ink optimized CBZ. It was initially developed for Kindle but since version 4.6 outputs valid EPUB 3.0 so despite its name, KCC is actually a comic/manga to EPUB converter that every e-reader owner can happily use. It can also optionally optimize images by applying a number of transformations.

## Warning
KCC is not Amazon's Kindle Comic Creator (AKKC) nor is it in any way endorsed by Amazon. Amazon's tool is for comic publishers and involves a lot of manual effort, while KCC is for comic/manga readers. AKKC in no way is a replacement for KCC so you can be quite confident that the development will carry on.

## Input formats
KCC can understand and convert from, at the moment, the following input types:
* Folders containing: PNG, JPG, GIF or WebP files
* CB7, 7Z
* CBR, RAR
* CBZ, ZIP
* PDF (only extracting JPG images)

## Output formats
* CBZ
* EPUB
* MOBI/AZW3 (see [MOBI support](#mobi-support))

## MOBI support
To support output to MOBI files, you have to download KindleGen manually and place *kindlegen.exe* into directory where KCC is installed.

## Parameters
* `/InstallationPath:` - where to install the binaries
    - Default value: `"$env:ProgramFiles\Kindle Comic Converter"`
* `/CreateDesktopIcon` - creates a desktop icon
    - Not created by default
* `/CBZassociation` - associates KCC as the default app for *.cbz files
    - Not associated by default
* `/CBRassociation` - associates KCC as the default app for *.cbr files
    - Not associated by default
* `/CB7association` - associates KCC as the default app for *.cb7 files
    - Not associated by default

### Examples
* Install into `D:\KCC` directory
    ```
    choco install kindle-comic-converter --params "/InstallationPath:"D:\KCC""
    ```
* Install with all file associations
    ```
    choco install kindle-comic-converter --params "/CBZassociation /CBRassociation /CB7association"
    ```
* Install and create desktop icon
   ```
   choco install kindle-comic-converter --params "/CreateDesktopIcon"
   ```