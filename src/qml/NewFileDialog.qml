import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


Item {
    property var dialogInstance

    function open() {
        dialogInstance = PopupUtils.open(filenameDialogComponent);
        dialogInstance.selected.connect(function(){ accepted(); });
        dialogInstance.canceled.connect(function(){ canceled(); });
    }

    signal accepted()
    signal canceled()

    Component {
        id: filenameDialogComponent

        Dialog {
            id: dialog

            signal selected(string filename)
            signal canceled()

            title: i18n.tr("New file")
            text: i18n.tr("Are you sure to create a new file? All unsaved changes will be lost.")

            Button {
                text: i18n.tr("Discard")
                color: UbuntuColors.orange
                onClicked: {
                    PopupUtils.close(dialog);
                    canceled();
                }
            }

            Button {
                text: i18n.tr("Cancel")
                onClicked: {
                    PopupUtils.close(dialog);
                    selected(filenameInput.text);
                }
            }
        }
    }
}
