import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    header: MarkHeader {
        title: "Start"
    }

    Button {
        anchors.centerIn: parent
    }

    BottomEdge {
        id: bottomEdge
        height: parent.height - header.height
        hint.text: "New file"
        hint.iconName: "compose"
        hint.onClicked: bottomEdge.commit()
    }
}

