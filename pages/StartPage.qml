import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

Rectangle {
    width: 360
    height: 360
    id: root
    
    // Signal to switch page
    signal switchPage(int pageId)

    // Welcome text
    Text {
        color: "#232629"
        text: qsTr("Welcome")
        font.weight: Font.Thin
        font.pixelSize: 72
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 70
    }

    // Button to start setup

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        flat: true
        anchors.top: parent.top
        anchors.topMargin: parent.height - 70
        onClicked: function(){
            root.switchPage(1);
        }

        contentItem: Text {
            color: "#3daee9"
            text: qsTr("Tap to start setuping your phone")
            verticalAlignment: Text.AlignVCenter
            SequentialAnimation on color {
                loops: Animation.Infinite
                ColorAnimation { from: "#3daee9"; to: "#FFFFFF"; duration: 3000 }
                ColorAnimation { from: "#FFFFFF"; to: "#3daee9"; duration: 3000 }
            }
        }        

    }
}
