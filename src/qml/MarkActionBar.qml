import QtQuick 2.4
import Ubuntu.Components 1.3
import "mark.js" as Marker

ActionBar {
    anchors {
       bottom: parent.bottom
       right: parent.right
    }
    numberOfSlots: 6
    actions: [
        Action {
           iconName: "edit-undo"
           text: i18n.tr("Undo")
           enabled: markTextArea.canUndo
           onTriggered: {
               markTextArea.undo()
               markTextArea.focus = true;
           }
        },
        Action {
           iconName: "edit-redo"
           text: i18n.tr("Redo")
           enabled: markTextArea.canRedo
           onTriggered: {
               markTextArea.redo()
               markTextArea.focus = true;
           }
        },
        Action {
           iconName: "view-list-symbolic"
           text: i18n.tr("Insert list")
           onTriggered: {
               markTextArea.insert(markTextArea.cursorPosition, "%1 ".arg(settings.defaultBulletCharacter))
               markTextArea.focus = true;
           }
        },
        Action {
           iconName: "text-css-symbolic"
           text: i18n.tr("Insert code")
           onTriggered: {
               var pos = markTextArea.cursorPosition + 4;
               markTextArea.insert(markTextArea.cursorPosition, "```\n\n```");
               markTextArea.cursorPosition = pos;
               markTextArea.focus = true;
           }
        },
        Action {
           iconName: "stock_link"
           text: i18n.tr("Insert link")
           onTriggered: {
               var start = markTextArea.cursorPosition + 1;
               var end = markTextArea.cursorPosition + 4;
               markTextArea.insert(markTextArea.cursorPosition, "[alt](url)");
               markTextArea.select(start, end);
               markTextArea.focus = true;
           }
        },
        Action {
           text: i18n.tr("Insert title")
           onTriggered: {
               markTextArea.insert(markTextArea.cursorPosition, "# ");
               markTextArea.focus = true;
           }
        },
        Action {
           text: i18n.tr("Insert image")
           iconName: "insert-image"
           onTriggered: {
               var start = markTextArea.cursorPosition + 7;
               var end = markTextArea.cursorPosition + 10;
               markTextArea.insert(markTextArea.cursorPosition, "![alt](url)");
               markTextArea.select(start, end);
               markTextArea.focus = true;
           }
        },
        Action {
           text: i18n.tr("Insert line")
           onTriggered: {
               markTextArea.insert(markTextArea.cursorPosition, "\n\n---\n");
           }
        },
        Action {
           text: i18n.tr("Insert quote")
           onTriggered: {
               markTextArea.insert(markTextArea.cursorPosition, "\n> \n> %1\n> \n\n".arg(i18n.tr("Quote")));
           }
        },
        Action {
           text: i18n.tr("Italic")
           onTriggered: {
               Marker.markSelected("*", i18n.tr("Italic text"));
           }
        },
        Action {
           text: i18n.tr("Bold")
           onTriggered: {
               Marker.markSelected("**", i18n.tr("Bold text"));
           }
        },
        Action {
           text: i18n.tr("Strikethrough")
           onTriggered: {
               Marker.markSelected("~~", i18n.tr("Strikethrough text"));
           }
        }
    ]

    Keys.onPressed: {
        if (event.key === Qt.Key_Z && (event.modifiers & Qt.ControlModifier)) {
            if (markTextArea.canUndo)
                markTextArea.undo();
        }
        else if (event.key === Qt.Key_Z && (event.modifiers & Qt.ControlModifier)  && (event.modifiers & Qt.ShiftModifier)) {
            if (markTextArea.canRedo)
                markTextArea.redo();
        }
    }

    Component.onCompleted: {
        Marker.textArea = markTextArea;
    }
}
