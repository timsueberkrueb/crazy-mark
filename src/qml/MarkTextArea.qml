import QtQuick 2.4
import Ubuntu.Components 1.3


TextArea {
    objectName: "markTextArea"

    property bool autoCompletion: true
    property bool setDirty: true
    property bool loaded: false

    signal renderRequested()

    font.family: "Ubuntu Mono"
    persistentSelection: true
    wrapMode: TextEdit.WordWrap

    onTextChanged: {
        if (!loaded) {
            loaded = true;
            return
        }
        if (autoCompletion) {
            // Auto-completion
            var character = getText(cursorPosition-1, cursorPosition);
            if (text.length > d.lastTextLength) {   // only autocomplete if text was extended
                switch (character) {
                    case "(":
                        insert(cursorPosition, ")");
                        cursorPosition = cursorPosition-1;
                        break;
                    case "[":
                        insert(cursorPosition, "]");
                        cursorPosition = cursorPosition-1;
                        break;

                }
            }
        }
        d.lastTextLength = text.length;
        if (setDirty)
            contentManager.fileDirty = true;
        renderRequested();
    }

    Keys.priority: Keys.AfterItem   // Handle auto-completion after regular events have been processed
                                    // Otherwise this will disturb selection handling etc.
    Keys.onPressed: {
        if (autoCompletion) {
            // Auto-completion after return
            if (event.key === Qt.Key_Return) {
                var bullets = ["*", "-", "+", ">"];
                var pos = cursorPosition-1;
                var current_char = "";
                var current_start = false;
                var found_mark = false;
                // Find the last \n character
                while (pos > 0) {
                    current_char = getText(pos-1, pos);
                    if (!current_start) {
                        if (current_char === "\n") {
                            current_start = pos;
                            break;
                        }
                        pos--;
                        // Beginning of document
                        if (pos === 0) {
                            current_start = pos;
                        }
                    }
                }
                pos++;
                // Search for special characters
                if (current_start !== false) {
                    while (pos < text.length) {
                        current_char = getText(pos-1, pos);
                        if (bullets.indexOf(current_char) != -1 && getText(pos, pos+1) === " ") {
                            found_mark = current_char;
                            break;
                        }
                        else if (current_char != " ")
                            break;
                        pos++;
                    }
                }
                // Auto-complete if a special character was found
                if (bullets.indexOf(found_mark) != -1) {
                    if (getText(pos, pos+1)  === " " && getText(pos+1, pos+2) === "\n")
                        remove(pos-1, cursorPosition);                    // Automatically remove last bullet
                    else
                        insert(cursorPosition, current_char + " ");       // Automatically insert bullet
                }
            }
        }
    }

    QtObject {
        id: d
        property string lastTextLength: text.length
    }
}
