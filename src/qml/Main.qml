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
        anchorToKeyboard: true

        theme.palette: Palette {
            normal.foreground: "white"
            normal.backgroundText: "white"
            disabled.backgroundText: UbuntuColors.lightGrey
            normal.background: UbuntuColors.ash
            highlighted.background: UbuntuColors.darkGrey
        }

        // Shortcuts
        Keys.onPressed: {
            if (event.modifiers & Qt.ControlModifier) {
                switch (event.key) {
                    case Qt.Key_N:
                        editorPage.panel.actions[0].trigger();
                        break;
                    case Qt.Key_O:
                        editorPage.panel.actions[1].trigger();
                        break;
                    case Qt.Key_S:
                        editorPage.panel.actions[2].trigger();
                        break;
                }
            }
            else if (event.key == Qt.Key_F5)
                editorPage.panel.actions[4].trigger();

        }

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

            primaryPage: editorPage

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

            MarkSettingsPage {
                id: settingsPage
            }

            MarkEditorPage {
                id: editorPage
            }

            MarkViewPage {
                id: viewPage
            }

            MarkAboutPage {
                id: aboutPage
            }
        }

        ContentManager {
            id: contentManager
            textArea: editorPage.textArea
            onFileOpened: {
                contentManager.fileDirty = false;
                editorPage.textArea.setDirty = false;
                editorPage.textArea.text = text;
                editorPage.textArea.setDirty = true;
            }
        }

        Component.onCompleted: {
            if (settings.openPreview)
                pageView.addPageToNextColumn(editorPage, viewPage, {});
        }
    }
    Component.onCompleted: show();
}
