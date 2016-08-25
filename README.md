# Crazy Mark

A simple markdown editor for Ubuntu

## Translations
Please help translating Crazy Mark [on Transifex](https://www.transifex.com/tim-sueberkrueb/crazy-mark/).

## Installation

### Ubuntu Store
Crazy Mark is available for download from the [Ubuntu Store](https://uappexplorer.com/app/crazy-mark.timsueberkrueb).

### Ubuntu Desktop
Make sure you have all dependencies installed:
```
sudo apt update
sudo apt install qt5-default
sudo apt install qtdeclarative5-dev qtbase5-dev
sudo apt install qtdeclarative5-ubuntu-content1
sudo apt install libqt5svg5-dev
```
Clone, build and run:
```
git clone https://github.com/tim-sueberkrueb/crazy-mark
cd crazy-mark
qmake; make
./crazy-mark
```
Tested on Ubuntu 16.04.

### Develop for Ubuntu phone
Make sure you have the [Ubuntu SDK installed](https://developer.ubuntu.com/en/phone/platform/sdk/installing-the-sdk/).
Open the project (File > Open file or project > Select `crazy-mark.pro`)

Select and/or create all necessary build kits in the `Projects` tab.

Attach a device and click the run button.

## Included third-party software
The following third-party software comes with Crazy Mark and is licensed as specified:
* [Marked.js](https://github.com/chjj/marked) by [Christopher Jeffrey](https://github.com/chjj/) licensed under the MIT License (see LICENSE.MIT)
* [Pecita font](https://www.fontsquirrel.com/fonts/Pecita) by [Philippe Cochy](https://www.fontsquirrel.com/fonts/list/foundry/philippe-cochy) licensed under the [SIL Open Font License, Version 1.1](https://www.fontsquirrel.com/license/Pecita).

## License and Copyright

Copyright © 2016 Tim Süberkrüb

This application is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See LICENSE for more information.




