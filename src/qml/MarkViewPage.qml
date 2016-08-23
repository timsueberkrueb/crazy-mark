import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    property MarkView markView: markView

    header: MarkHeader {
        title: i18n.tr("Preview")
    }

    MarkView {
        id: markView
        anchors {
            top: parent.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
