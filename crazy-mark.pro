TEMPLATE = app
TARGET = crazy-mark

#load Ubuntu specific features
load(ubuntu-click)

QT += qml quick gui widgets svg
CONFIG += c++11

# specify the manifest file, this file is required for click
# packaging and for the IDE to create runconfigurations
UBUNTU_MANIFEST_FILE=click/manifest.json

# specify translation domain, this must be equal with the
# app name in the manifest file
UBUNTU_TRANSLATION_DOMAIN="crazy-mark.timsueberkrueb"

# specify the source files that should be included into
# the translation file, from those files a translation
# template is created in po/template.pot, to create a
# translation copy the template to e.g. de.po and edit the sources
UBUNTU_TRANSLATION_SOURCES+= \
    $$files(*.qml,true) \
    $$files(*.js,true) \
    $$files(*.desktop,true)

# specifies all translations files and makes sure they are
# compiled and installed into the right place in the click package
UBUNTU_PO_FILES+=$$files(po/*.po)

SOURCES += src/main.cpp \
    src/markhighlighter.cpp \
    src/palette.cpp \
    src/desktopfiledialog.cpp \
    src/markfile.cpp \
    src/settings.cpp \
    src/highlightutils.cpp

HEADERS += \
    src/markhighlighter.h \
    src/palette.h \
    src/desktopfiledialog.h \
    src/markfile.h \
    src/settings.h \
    src/highlightutils.h

RESOURCES += src/qml/qml.qrc \
    src/html/html.qrc \
    src/js/js.qrc \
    media/media.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  click/crazy-mark.timsueberkrueb.apparmor \
               click/crazy-mark.timsueberkrueb.apparmor.openstore \
               icon.png

#show all the files in QtCreator
OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               click/crazy-mark.timsueberkrueb.desktop \
               README.md

#specify where the config files are installed to
config_files.path = /
config_files.files += $${CONF_FILES}
INSTALLS+=config_files

desktop_file.path = /
desktop_file.files = click/crazy-mark.timsueberkrueb.desktop
desktop_file.CONFIG += no_check_exist
INSTALLS+=desktop_file

oxide_user_script.path = /
oxide_user_script.files = src/qml/oxide-user.js
INSTALLS+=oxide_user_script

# Default rules for deployment.
target.path = $${UBUNTU_CLICK_BINARY_PATH}
INSTALLS+=target

DISTFILES += \
    PrimaryPage.qml
