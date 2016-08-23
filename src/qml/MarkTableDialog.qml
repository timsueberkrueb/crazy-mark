import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

PopupBase {
    signal tableCreated(int columns, int rows, int cellWidth)

    width: units.dp(300)
    height: units.dp(264)
    z: 25

    UbuntuShape {
        id: background
        anchors.fill: parent
        backgroundColor: UbuntuColors.ash
    }

    Item {
        anchors {
            fill: background
            margins: units.gu(2)
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: units.gu(1)

            Label {
                text: "Create Table"
                fontSize: "x-large"
            }

            GridLayout {
                columns: 2

                Label {
                    text: i18n.tr("Columns")
                }

                TextField {
                    id: inputColumns
                    text: "3"
                    validator: IntValidator {
                        bottom: 1
                        top: 25
                    }
                    inputMethodHints: Qt.ImhDigitsOnly
                }

                Label {
                    text: i18n.tr("Rows")
                }

                TextField {
                    id: inputRows
                    text: "3"
                    validator: IntValidator {
                        bottom: 1
                        top: 25
                    }
                    inputMethodHints: Qt.ImhDigitsOnly
                }

                Label {
                    text: i18n.tr("Cell width")
                }

                TextField {
                    id: inputCellWidth
                    text: "10"
                    validator: IntValidator {
                        bottom: 1
                        top: 25
                    }
                    inputMethodHints: Qt.ImhDigitsOnly
                }
            }

            Row {
                width: parent.width
                spacing: units.gu(1)
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                Button {
                    text: i18n.tr("Cancel")
                    onClicked: hide();
                }

                Button {
                    text: i18n.tr("Create")
                    color: UbuntuColors.green
                    onClicked: {
                        tableCreated(parseInt(inputColumns.text), parseInt(inputRows.text), parseInt(inputCellWidth.text));
                        hide();
                    }
                }
            }
        }
    }
}
