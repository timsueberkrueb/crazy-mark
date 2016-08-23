import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    property bool toolbarVisible: settings.toolbarExpanded

    property MarkTextArea textArea: markTextArea
    property MarkPanel panel: panel

    header: MarkHeader {
        id: pageHeader
        title: contentManager.currentFile.fileName
               ? i18n.tr("%1%2 - Editor".arg(contentManager.currentFile.fileName).arg(contentManager.fileDirty ? "*" : ""))
               : i18n.tr("Editor")

        leadingActionBar.actions: [
            Action {
                iconName: "navigation-menu"
                text: i18n.tr("Menu")
                onTriggered: {
                    if (panel.opened)
                        panel.close();
                    else {
                        Qt.inputMethod.hide();
                        panel.open();
                    }
                }
            }
        ]

        trailingActionBar.actions: [
            Action {
                iconName: editorPage.toolbarVisible ? "toolkit_chevron-up_1gu" : "toolkit_chevron-down_1gu"
                text: editorPage.toolbarVisible ? i18n.tr("Hide toolbar") : i18n.tr("Show toolbar")
                onTriggered: {
                    editorPage.toolbarVisible = !editorPage.toolbarVisible
                }
            }
        ]

        extension: MarkActionBar {
            height: editorPage.toolbarVisible ? units.gu(4) : 0
            visible: editorPage.toolbarVisible

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    MarkTextArea {
        id: markTextArea
        anchors {
            top: parent.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        autoCompletion: settings.autoCompletion

        onRenderRequested: {
            // Render
            var req = viewPage.markView.rootFrame.sendMessage(viewPage.markView.usContext, "RENDER", {"text": text});
            req.onreply = function (msg) {
                callback(msg.result);
            }
            req.onerror = function (code, explanation) {
                console.error("Error " + code + " trying to render markdown in view: " + explanation);
            }
        }
    }

    MarkPanel {
        id: panel
        z: 25
        maximumHeight: parent.height - parent.header.height
        anchors {
            left: parent.left
            top: parent.header.bottom
        }
    }
}

