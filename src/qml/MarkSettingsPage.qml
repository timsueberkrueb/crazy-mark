import QtQuick 2.4
import Ubuntu.Components 1.3
import Mark 1.0

Page {
    header: MarkHeader {
        title: i18n.tr("Settings")

        trailingActionBar.actions: [
            Action {
                text: i18n.tr("About")
                iconName: "info"
                onTriggered: {
                    pageView.addPageToNextColumn(settingsPage, aboutPage, {});
                }
            }
        ]
    }

    Flickable {
        anchors {
            top: parent.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: units.gu(1)
        }
        contentHeight: column.childrenRect.height

        Column {
            id: column
            width: parent.width
            spacing: units.gu(1)

            Label {
                text: i18n.tr("Interface")
                fontSize: "x-large"
            }

            OptionSelector {
                id: selectorContentExchange
                text: i18n.tr("Content exchange via ...")
                model: {
                    if (confined)
                        return [
                            i18n.tr("Mark Dialog"),
                            i18n.tr("Content Hub")
                        ]
                    else
                        return [
                            i18n.tr("Mark Dialog"),
                            i18n.tr("Content Hub"),
                            i18n.tr("Desktop Dialog")
                        ]
                }
                onSelectedIndexChanged: {
                    switch (selectedIndex) {
                        case 0:
                            settings.contentExchangeMode = Settings.MarkDialog;
                            break;
                        case 1:
                            settings.contentExchangeMode = Settings.ContentHub;
                            break;
                        case 2:
                            settings.contentExchangeMode = Settings.Desktop;
                            break;
                    }
                    settings.save();
                }
                Component.onCompleted: {
                    switch (settings.contentExchangeMode) {
                        case Settings.MarkDialog:
                            selectedIndex = 0;
                            break;
                        case Settings.ContentHub:
                            selectedIndex = 1;
                            break;
                        case Settings.Desktop:
                            selectedIndex = 2;
                            break;
                    }
                }
            }

            Label {
                text: {
                    switch (settings.contentExchangeMode) {
                        case Settings.MarkDialog:
                            if (confined)
                                return i18n.tr("You're running in confined mode. You can only write files to '%1'".arg(dataPath))
                            else
                                return i18n.tr("Mark Dialog allows you to write to '%1'. If you wish more control choose Desktop Dialog.".arg(documentsPath))
                        case Settings.ContentHub:
                            return i18n.tr("Please note that due to platform limitations this option doesn't offer the best experience, yet. " +
                                           "Please make sure that you have the filemanager app installed.")
                        case Settings.Desktop:
                            return i18n.tr("Please note that content exchange using a desktop-style dialog is only usable with a mouse and keyboard connected.")
                    }
                }
                width: parent.width
                wrapMode: Text.WordWrap
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Row {
                spacing: units.gu(1)

                CheckBox {
                    onCheckedChanged: {
                        settings.toolbarExpanded = checked;
                        settings.save();
                    }
                    Component.onCompleted: {
                        checked = settings.toolbarExpanded;
                    }
                }

                Label {
                    text: i18n.tr("Start with expanded toolbar")
                }
            }

            Row {
                spacing: units.gu(1)

                CheckBox {
                    onCheckedChanged: {
                        settings.openPreview = checked;
                        settings.save();
                    }
                    Component.onCompleted: {
                        checked = settings.openPreview;
                    }
                }

                Label {
                    text: i18n.tr("Open preview on startup")
                }
            }

            Label {
                text: i18n.tr("Editor")
                fontSize: "x-large"
            }

            Row {
                spacing: units.gu(1)

                CheckBox {
                    id: checkboxAutoCompletion
                    onTriggered: {
                        settings.autoCompletion = !settings.autoCompletion;
                        settings.save();
                    }
                    Binding {
                        target: checkboxAutoCompletion
                        property: "checked"
                        value: settings.autoCompletion
                    }
                }

                Label {
                    text: i18n.tr("Auto completion")
                }
            }

            Label {
                text: "Markdown"
                fontSize: "x-large"
            }

            OptionSelector {
                property var bulletChars: [
                    "-",
                    "*",
                    "+"
                ]
                text: i18n.tr("Default bullet character")
                model: [
                    i18n.tr("Hyphen\t-"),
                    i18n.tr("Asterisk\t*"),
                    i18n.tr("Plus\t+"),
                ]
                onSelectedIndexChanged: {
                    settings.defaultBulletCharacter = bulletChars[selectedIndex];
                    settings.save();
                }
                Component.onCompleted: {
                    for (var i=0; i<model.length; i++) {
                        if (bulletChars[i] === settings.defaultBulletCharacter) {
                            selectedIndex = i;
                            break;
                        }
                    }
                }
            }
        }
    }
}
