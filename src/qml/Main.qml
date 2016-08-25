import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.Themes 1.3
import Ubuntu.Components.Themes.Ambiance 1.3


Window {
    title: "Crazy Mark"
    width: units.dp(840)
    height: units.dp(580)

    MainView {
        objectName: "mainView"
        anchors.fill: parent
        applicationName: "crazy-mark.timsueberkrueb"
        anchorToKeyboard: false

        QtObject {
            objectName: "paletteHelper"

            property color green: UbuntuColors.green
            property color red: UbuntuColors.red
            property color orange: UbuntuColors.orange
            property color blue: UbuntuColors.blue
            property color purple: UbuntuColors.purple
            property color darkGrey: UbuntuColors.darkGrey
            property color midGrey: UbuntuColors.coolGrey
            property color lightGrey: UbuntuColors.lightGrey
        }

        AdaptivePageLayout {
            id: pageView
            anchors.fill: parent

            primaryPage: primaryPage

            layouts: [
                // two columns
                PageColumnsLayout {
                    when: pageView.width > units.gu(80)
                    PageColumn {
                        fillWidth: true
                    }
                    PageColumn {
                        fillWidth: true
                    }
                },
                // single column
                PageColumnsLayout {
                    when: true
                    PageColumn {
                        minimumWidth: units.gu(20)
                        fillWidth: true
                    }
                }
            ]

            PrimaryPage {
                id: primaryPage
            }

            MarkSettingsPage {
                id: settingsPage
            }

            MarkViewPage {
                id: viewPage
            }

            MarkAboutPage {
                id: aboutPage
            }
        }

        Component.onCompleted: {
            if (settings.openPreview)
                pageView.addPageToNextColumn(primaryPage, viewPage, {});
        }
    }
    Component.onCompleted: show();
}
