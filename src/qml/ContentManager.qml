import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
import Ubuntu.Components.Popups 1.3
import Mark 1.0

Item {
    property bool fileDirty: false
    property bool fileOpen: false
    readonly property bool useContentHub: settings.contentExchangeMode == Settings.ContentHub
    property var textArea
    property MarkFile currentFile: MarkFile {}

    function newFile() {
        if (fileDirty)
            newFileDialog.open();
        else {
            newFileDialog.accepted();
        }
    }

    function askOpenFile() {
        if (useContentHub)
            importContentPopup.show();
        else {
            var fileName = desktopFileDialog.askOpenFile();
            if (fileName)
                openFile(Qt.resolvedUrl("file://"+fileName));
        }
    }

    function openFile(url) {
        currentFile.url = url;
        var text = currentFile.read();
        fileOpen = true;
        fileOpened(text);
    }

    function saveFile() {
        currentFile.write(textArea.text);
        fileDirty = false;
        if (useContentHub) {
            exportContentPopup.show();
        }
    }

    function askSaveFileAs() {
        if (useContentHub) {
            filenameDialog.open();
        }
        else {
            var filepath = desktopFileDialog.askSaveFileText(textArea.text);
            if (filepath) {
                currentFile.url = Qt.resolvedUrl("file://" + filepath);
                currentFile.fileName = filepath.replace(/^.*[\\\/]/, '');
                fileOpen = true;
                saveFile();
            }
        }
    }

    signal fileOpened(var text)

    ImportContentPopup {
        id: importContentPopup
        onFileImported: {
            openFile(url);
        }
    }

    ExportContentPopup {
        id: exportContentPopup
        url: currentFile.url
    }

    FilenameDialog {
        id: filenameDialog
        onSelected: {
            currentFile.url = Qt.resolvedUrl("file://" + dataPath + filename);
            currentFile.fileName = filename;
            currentFile.write(textArea.text);
            fileOpen = true;
            fileDirty = false;
            exportContentPopup.contentItem.url = currentFile.url;
            exportContentPopup.show();
        }
    }

    NewFileDialog {
        id: newFileDialog
        onAccepted: {
            textArea.text = "";
            fileOpen = false;
            currentFile.url = "";
            currentFile.fileName = "";
        }
    }
}
