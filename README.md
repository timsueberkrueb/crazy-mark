# Crazy Mark

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/timsueberkrueb/crazy-mark.svg)](https://github.com/timsueberkrueb/crazy-mark/releases)
[![GitHub issues](https://img.shields.io/github/issues/timsueberkrueb/crazy-mark.svg)](https://github.com/timsueberkrueb/crazy-mark/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2018.svg)](https://github.com/timsueberkrueb/crazy-mark/commits/develop)

A simple markdown editor for Ubuntu

Crazy Mark is available for download from the [Open Store](https://open-store.io/app/crazy-mark.timsueberkrueb).

## Dependencies

Qt >= 5.4.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtsvg](http://code.qt.io/cgit/qt/qtsvg.git/)

The following modules and their dependencies are required:

 * [Ubuntu UI Toolkit 1.3](https://github.com/ubports/ubuntu-ui-toolkit)


## Installation

We use [clickable](http://clickable.bhdouglass.com/).

To build and package the application, run:

```bash
clickable build
clickable build-click
```

To install the application on your device, make sure your device is
connected to your development machine with an USB cable and developer mode is enabled.

Run:

```
clickable install
clickable launch
```

## Translations
Please help translating Crazy Mark [on Transifex](https://www.transifex.com/tim-sueberkrueb/crazy-mark/).

## Credits
* Thanks to [Sam Hewitt](http://samuelhewitt.com/) for creating the [Ubuntu Icon Resource Kit](https://github.com/snwh/ubuntu-icon-resource-kit) which was used to create the application icon.
* Thanks to all translators [on Transifex](https://www.transifex.com/tim-sueberkrueb/crazy-mark/).

## Included third-party software
The following third-party software comes with Crazy Mark and is licensed as specified:
* [Marked.js](https://github.com/chjj/marked) by [Christopher Jeffrey](https://github.com/chjj/) licensed under the MIT License (see `src/js/LICENSE.marked`)
* [Pecita font](https://www.fontsquirrel.com/fonts/Pecita) by [Philippe Cochy](https://www.fontsquirrel.com/fonts/list/foundry/philippe-cochy) licensed under the [SIL Open Font License, Version 1.1](https://www.fontsquirrel.com/license/Pecita).

## Licensing

Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.
