import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    header: MarkHeader {
        title: i18n.tr("About")
    }

    Flickable {
        id: flickable
        anchors {
            top: parent.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        contentHeight: contentColumn.childrenRect.height + contentColumn.padding * 2

        Column {
            id: contentColumn
            property int padding: units.dp(16)
            x: padding
            y: padding
            width: parent.width - (2 * padding)

            spacing: units.gu(1)

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Crazy Mark"
                fontSize: "x-large"
            }

            UbuntuShape {
                anchors.horizontalCenter: parent.horizontalCenter
                width: units.dp(64)
                height: units.dp(64)
                source: Image {
                    source: "icon.png"
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: i18n.tr("A markdown editor for Ubuntu")
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: i18n.tr("Version %1").arg(appVersion)
            }

            Item { height: units.gu(2); width: parent.width }   // Spacer

            Label {
                text: i18n.tr("Source code available on <a href='%1'>GitHub</a>.").arg("https://github.com/timsueberkrueb/crazy-mark")
                width: parent.width
                wrapMode: Text.WordWrap
                linkColor: UbuntuColors.orange
                onLinkActivated: Qt.openUrlExternally(link);
            }

            Label {
                text: i18n.tr("Credits")
                fontSize: "large"
            }

            Label {
                text: i18n.tr("Thanks to <a href='%1'>Sam Hewitt</a> for creating the <a href='%2'>Ubuntu Icon Resource Kit</a> which was used to create the application icon.")
                       .arg("http://samuelhewitt.com/")
                       .arg("https://github.com/snwh/ubuntu-icon-resource-kit")
                width: parent.width
                wrapMode: Text.WordWrap
                linkColor: UbuntuColors.orange
                onLinkActivated: Qt.openUrlExternally(link);
            }

            Label {
                text: i18n.tr("The following third-party software comes with Crazy Mark and is licensed as specified:")
                width: parent.width
                wrapMode: Text.WordWrap
            }

            Label {
                text: i18n.tr("- <a href='%1'>Marked.js</a> by <a href='%2'>Christopher Jeffrey</a> licensed under the <a href='%3'>MIT License</a>")
                              .arg("https://github.com/chjj/marked")
                              .arg("https://github.com/chjj/")
                              .arg("https://opensource.org/licenses/MIT")
                width: parent.width
                wrapMode: Text.WordWrap
                linkColor: UbuntuColors.orange
                onLinkActivated: Qt.openUrlExternally(link);
            }

            Label {
                text: i18n.tr("- <a href='%1'>Pecita font</a> by <a href='%2'>Philippe Cochy</a> licensed under the <a href='%3'>SIL Open Font License, Version 1.1</a>")
                              .arg("https://www.fontsquirrel.com/fonts/Pecita")
                              .arg("https://www.fontsquirrel.com/fonts/list/foundry/philippe-cochy")
                              .arg("https://www.fontsquirrel.com/license/Pecita")
                width: parent.width
                wrapMode: Text.WordWrap
                linkColor: UbuntuColors.orange
                onLinkActivated: Qt.openUrlExternally(link);
            }

            Label {
                text: i18n.tr("License and Copyright")
                fontSize: "large"
            }

            Label {
                text: ("This application is free software: you can redistribute it and/or modify it under the terms of" +
                       " the GNU General Public License as published by the Free Software Foundation, either version 3 of the " +
                       "License, or (at your option) any later version.<br/><br/>Copyright (C) 2020 Tim Süberkrüb<br/>")
                width: parent.width
                wrapMode: Text.WordWrap
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.dp(8)

                Button {
                    text: "★ %1".arg(i18n.tr("Store"))
                    color: UbuntuColors.green
                    onClicked: {
                        Qt.openUrlExternally("openstore://crazy-mark.timsueberkrueb")
                    }
                }

                Button {
                    text: "🐞 %1".arg(i18n.tr("Report bug"))
                    color: UbuntuColors.orange
                    onClicked: {
                        Qt.openUrlExternally("https://github.com/timsueberkrueb/crazy-mark/issues/new");
                    }
                }

                Button {
                    text: "♥ %1".arg(i18n.tr("Contribute"))
                    color: UbuntuColors.darkAubergine
                    onClicked: {
                        Qt.openUrlExternally("https://github.com/timsueberkrueb/crazy-mark");
                    }
                }
            }
        }
    }
}
