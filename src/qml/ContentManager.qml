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

    function askOpenFile(skipCheckDirty) {
        // disabled for now when using the desktop-style dialog
        // because it segfaults when opened from this context
        if (settings.contentExchangeMode !== Settings.Desktop) {
            if (!skipCheckDirty) {
                if (fileDirty) {
                    openUnsavedDialog.open();
                    return;
                }
            }
        }
        switch (settings.contentExchangeMode) {
            case Settings.MarkDialog:
                fileSelectorPage.mode = fileSelectorPage.open;
                var page = pageView.addPageToNextColumn(primaryPage, fileSelectorPage, {});
                break;
            case Settings.ContentHub:
                importContentPopup.show();
                break;
            case Settings.Desktop:
                var fileName = desktopFileDialog.askOpenFile();
                if (fileName)
                    openFile(Qt.resolvedUrl("file://"+fileName));
                break;
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
        switch (settings.contentExchangeMode) {
            case Settings.MarkDialog:
                fileSelectorPage.mode = fileSelectorPage.save;
                var page = pageView.addPageToNextColumn(primaryPage, fileSelectorPage, {});
                break;
            case Settings.ContentHub:
                filenameDialog.open();
                break;
            case Settings.Desktop:
                var filepath = desktopFileDialog.askSaveFileText(textArea.text);
                if (filepath) {
                    currentFile.url = Qt.resolvedUrl("file://" + filepath);
                    currentFile.fileName = filepath.replace(/^.*[\\\/]/, '');
                    fileOpen = true;
                    saveFile();
                }
                break;
        }
    }

    function askCloseEditor() {
        if (fileDirty)
            confirmCloseDialog.open();
        else
            confirmCloseDialog.accepted();
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
            fileDirty = false;
            currentFile.url = "";
            currentFile.fileName = "";
        }
    }

    ConfirmDialog {
        id: openUnsavedDialog

        title: i18n.tr("Unsaved changes")
        text: i18n.tr("You have unsaved changes. Are you sure to continue?")

        onAccepted: {
            askOpenFile(true);
        }
    }

    ConfirmDialog {
        id: confirmCloseDialog

        title: i18n.tr("Close file")
        text: i18n.tr("You have unsaved changes. Are you sure to close the file?")

        onAccepted: {
            newFileDialog.accepted();
            primaryPage.closeEditor();
        }
    }

    MarkFileSelectorPage {
        id: fileSelectorPage
        rootFolder: confined ? Qt.resolvedUrl("file://" + dataPath) : Qt.resolvedUrl("file://" + documentsPath)
        folder: rootFolder
        onSelected: {
            if (mode === open) {
                openFile(Qt.resolvedUrl("file://" + filePath));
                pageView.removePages(fileSelectorPage);
            }
            else if (mode === save) {
                currentFile.url = filePath;
                currentFile.fileName = fileName;
                fileOpen = true;
                saveFile();
                pageView.removePages(fileSelectorPage);
            }
        }
        onCanceled: {
            pageView.removePages(fileSelectorPage);
        }
    }
}
