import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


Item {
    id: item
    property var dialogInstance
    property string title
    property string text

    function open() {
        dialogInstance = PopupUtils.open(dialogComponent);
        dialogInstance.selected.connect(function(){ accepted(); });
        dialogInstance.canceled.connect(function(){ canceled(); });
    }

    signal accepted()
    signal canceled()

    Component {
        id: dialogComponent

        Dialog {
            id: dialog

            signal selected(string filename)
            signal canceled()

            title: item.title
            text: item.text

            Button {
                text: i18n.tr("Yes")
                color: UbuntuColors.orange
                onClicked: {
                    PopupUtils.close(dialog);
                    accepted();
                }
            }

            Button {
                text: i18n.tr("No")
                onClicked: {
                    PopupUtils.close(dialog);
                    canceled();
                }
            }
        }
    }
}
