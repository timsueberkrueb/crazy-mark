import QtQuick 2.4
import Ubuntu.Components 1.3

Panel {
    id: panel
    focus: true

    property int maximumHeight: 256

    property QtObject options: QtObject {
        property bool autoCompletion: checkboxAutoCompletion.checked
    }

    property list<Action> actions: [
        Action {
            text: i18n.tr("New")
            iconName: "empty-symbolic"
            onTriggered: {
                contentManager.newFile();
            }
            shortcut: "Ctrl+N"
        },
        Action {
            text: i18n.tr("Open")
            iconName: "document-open"
            onTriggered: {
                contentManager.askOpenFile();
            }
            shortcut: "Ctrl+O"
        },
        Action {
            text: i18n.tr("Save")
            iconName: "document-save"
            enabled: contentManager.fileOpen
            onTriggered: {
                contentManager.saveFile();
            }
            shortcut: "Ctrl+S"
        },
        Action {
            text: i18n.tr("Save as")
            iconName: "document-save-as"
            onTriggered: {
                contentManager.askSaveFileAs();
            }
        },
        Action {
            text: i18n.tr("Close")
            iconName: "close"
            onTriggered: {
                contentManager.askCloseEditor();
            }
        },
        Action {
            text: i18n.tr("Preview")
            iconName: "slideshow"
            onTriggered: {
              pageView.addPageToNextColumn(primaryPage, viewPage, {});
            }
            shortcut: "F5"
        }
    ]

    locked: true
    align: Qt.AlignLeft
    width: Math.min(parent.width*(3/5), units.gu(32))
    height: rect.height

    Rectangle {
        id: rect
        width: parent.width
        height: Math.min(column.childrenRect.height, maximumHeight)
        color: theme.palette.normal.background

        Flickable {
            anchors.fill: parent
            contentHeight: column.childrenRect.height
            clip: true

            Column {
                id: column
                width: parent.width

                Repeater {
                    model: actions
                    delegate: ListItem {
                        enabled: modelData.enabled
                        width: parent.width

                        SlotsLayout {
                            anchors.fill: parent

                            mainSlot: Label {
                                text: modelData.text
                            }

                            Icon {
                                SlotsLayout.position: SlotsLayout.Leading
                                name: modelData.iconName
                                width: units.gu(2)
                                color: theme.palette.normal.foregroundText
                            }
                        }

                        onClicked: {
                            modelData.trigger();
                            panel.close();
                        }
                    }

                }

                ListItem {
                    width: parent.width
                    height: units.gu(4)

                    Label {
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            margins: units.gu(1)
                        }
                        text: i18n.tr("Options")
                        font.bold: true
                    }
                }

                ListItem {
                    width: parent.width
                    height: units.gu(6)

                    Column {
                        id: columnOptions
                        anchors {
                            fill: parent
                            margins: units.gu(2)
                        }
                        spacing: units.gu(1)

                        Row {
                            spacing: units.gu(1)

                            CheckBox {
                                id: checkboxAutoCompletion
                                onTriggered: {
                                    settings.autoCompletion = !settings.autoCompletion;
                                    settings.save();
                                }
                                Binding {
                                    target: checkboxAutoCompletion
                                    property: "checked"
                                    value: settings.autoCompletion
                                }
                            }

                            Label {
                                text: i18n.tr("Auto completion")
                            }
                        }
                    }
                }

                ListItem {
                    width: parent.width

                    SlotsLayout {
                        anchors.fill: parent

                        mainSlot: Label {
                            text: i18n.tr("Settings")
                        }

                        Icon {
                            SlotsLayout.position: SlotsLayout.Leading
                            name: "settings"
                            width: units.gu(2)
                            color: theme.palette.normal.foregroundText
                        }
                    }

                    onClicked: {
                        pageView.addPageToNextColumn(primaryPage, settingsPage, {});
                        panel.close();
                    }
                }
            }
        }

        InverseMouseArea {
            visible: panel.opened
            anchors.fill: parent
            onPressed: {
                panel.close();
            }
        }
    }
}
