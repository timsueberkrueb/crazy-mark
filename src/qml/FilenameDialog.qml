import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


Item {
    property var dialogInstance

    function open() {
        dialogInstance = PopupUtils.open(filenameDialogComponent);
        dialogInstance.selected.connect(function(filename){
            selected(filename);
        });
        dialogInstance.canceled.connect(function(){ canceled(); });
    }

    signal selected(string filename)
    signal canceled()

    Component {
        id: filenameDialogComponent

        Dialog {
            id: dialog

            signal selected(string filename)
            signal canceled()

            title: i18n.tr("Save file")

            TextField {
                id: filenameInput
                text: "file.md"
                placeholderText: i18n.tr("Filename")
                Component.onCompleted: select(0, text.length-3)
            }

            Button {
                text: i18n.tr("Save")
                color: UbuntuColors.green
                onClicked: {
                    PopupUtils.close(dialog);
                    selected(filenameInput.text);
                }
            }

            Button {
                text: i18n.tr("Cancel")
                color: UbuntuColors.orange
                onClicked: {
                    PopupUtils.close(dialog);
                    canceled();
                }
            }
        }
    }
}
