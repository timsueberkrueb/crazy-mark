import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtGraphicalEffects 1.0

Page {
    id: primaryPage

    property var editor: {
        if (bottomEdge.contentItem)
            return bottomEdge.contentItem.editorPage ? bottomEdge.contentItem.editorPage : false;
        return false;
    }

    onEditorChanged: {
        if (editor && bottomEdge.openFile)
            bottomEdge.performOpenFileAction();
    }

    function closeEditor() {
        bottomEdge.collapse();
    }

    property Component editorPageComponent: Component {
        Rectangle {
            width: primaryPage.width
            height: primaryPage.height

            property var editorPage: loader.item

            Loader {
                id: loader
                anchors.fill: parent
                sourceComponent: Component {
                    MarkEditorPage {
                        anchors.fill: parent
                    }
                }
            }
        }
    }

    header: MarkHeader {
        title: "Crazy Mark"

        trailingActionBar.actions: [
            Action {
                text: i18n.tr("Settings")
                iconName: "settings"
                onTriggered: {
                    pageView.addPageToNextColumn(primaryPage, settingsPage, {});
                }
            },
            Action {
                text: i18n.tr("New file")
                iconName: "add"
                onTriggered: bottomEdge.commit()
            }
        ]
    }

    Item {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        MarkFileSelector {
            id: fileSelector
            anchors.fill: parent
            rootFolder: confined ? Qt.resolvedUrl("file://" + dataPath) : Qt.resolvedUrl("file://" + documentsPath)
            folder: rootFolder
            onFileSelected: {
                bottomEdge.openFile = true;
                bottomEdge.filePath = filePath;
                bottomEdge.fileName = fileName;
                bottomEdge.commit();
            }
        }

        Image {
            id: imageArrow
            visible: fileSelector.count == 0
            anchors {
                top: parent.top
                right: parent.right
                topMargin: units.gu(1)
                rightMargin: units.gu(7)
            }
            source: "media/images/arrow.svg"
            smooth: true
        }

        Label {
            visible: fileSelector.count == 0
            text: i18n.tr("Create your first file")
            font.family: "Pecita"
            font.pixelSize: units.dp(18)
            font.bold: true
            anchors {
                right: imageArrow.left
                margins: units.gu(2)
                verticalCenter: imageArrow.bottom
            }
            Component.onCompleted: console.log(color)
        }

        Label {
            id: noFilesLabels
            anchors.centerIn: parent
            visible: fileSelector.count == 0
            text: i18n.tr("Documents or folders you create will show up here.")
            width: Math.min(parent.width - units.gu(2), textMetrics.width)
            wrapMode: Text.WordWrap

            TextMetrics {
                id: textMetrics
                text: noFilesLabels.text
                font: noFilesLabels.font
            }
        }
    }

    BottomEdge {
        id: bottomEdge

        property bool openFile: false
        property string filePath: ""
        property string fileName

        function performOpenFileAction() {
            openFile = false;
            editor.contentManager.openFile(Qt.resolvedUrl("file://" + filePath));
        }

        height: parent.height
        hint.text: i18n.tr("New file")
        hint.iconName: "compose"
        hint.onClicked: bottomEdge.commit()
        contentComponent: editorPageComponent
        onCommitCompleted: {
            if (openFile && editor) {
                performOpenFileAction();
            }
        }
    }
}

