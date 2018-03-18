import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Page {
    id: selectorPage
    property int open: 0
    property int save: 1

    property int mode: save
    property string fileName: inputFileName.text
    readonly property string filePath: fileSelector.folder + "/" + fileName

    property alias folder: fileSelector.folder
    property alias rootFolder: fileSelector.rootFolder

    property list<Action> actions: [
        Action {
            visible: mode === save
            enabled: fileName !== ""
            iconName: "ok"
            text: i18n.tr("Select")
            onTriggered: {
                inputFileName.accepted();
            }
        },
        Action {
            iconName: "close"
            text: i18n.tr("Cancel")
            onTriggered: {
                canceled();
            }
        }
    ]

    readonly property var markdownExtensions: [".md", ".markdown", ".mdown", ".mkdn", ".mkd", ".mdwn", ".mdtxt", ".mdtext", ".text"]

    signal selected(string fileName, string filePath)
    signal canceled()

    header: mode === open ? openHeader : saveHeader

    MarkHeader {
        id: openHeader
        visible: mode === open
        title: i18n.tr("Open file")
        trailingActionBar.actions: actions
    }

    MarkHeader {
        id: saveHeader
        visible: mode === save
        contents: Item {
            anchors.fill: parent

            TextField {
                id: inputFileName
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                placeholderText: i18n.tr("Save as ...")
                onAccepted: {
                    var hasExtension = false;
                    for (var i=0; i<markdownExtensions.length; i++) {
                        if (text.indexOf(markdownExtensions[i], text.length - markdownExtensions[i].length) !== -1) {
                            hasExtension = true;
                            break;
                        }
                    }
                    if (!hasExtension)
                        text += ".md";

                    if (fileSelector.fileExists(filePath))
                        PopupUtils.open(fileExistsDialog, selectorPage, {fileName: fileName});
                    else
                        selected(fileName, filePath);
                }
            }
        }
        trailingActionBar.actions: actions
    }

    MarkFileSelector {
        id: fileSelector
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        onFileSelected: {
            inputFileName.text = fileName;
            if (mode == open)
                selected(fileName, filePath);
        }
    }

    Component {
        id: fileExistsDialog

        Dialog {
            id: dialog

            property string fileName

            title: i18n.tr("File exists")
            text: i18n.tr("Do you want to overwrite %1?".arg(fileName))

            Button {
                text: i18n.tr("Yes")
                color: UbuntuColors.orange
                onClicked: {
                    selected(fileName, filePath);
                    PopupUtils.close(dialog);
                }
            }

            Button {
                text: i18n.tr("No")
                onClicked: {
                    PopupUtils.close(dialog);
                }
            }
        }
    }
}

