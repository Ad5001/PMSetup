import QtQuick 2.7
import QtQuick.Controls 2.2

Rectangle {
    id: root
    property bool active: false;
    property string text: "";
    z: 2
    Rectangle {
        id: buble
        height: 20
        width: 20
        radius: 10
        color: root.active ? "#3daee9" : "#4d4d4d"
    }
    Text {
        anchors.top: buble.bottom
        width: 64
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 12
        text: root.text
    }
}