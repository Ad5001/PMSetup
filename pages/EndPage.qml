import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import Process 1.0
import "qrc:/ui" as UI

UI.Page {

    
    signal goBack()
    
    
    width: 360
    height: 360
    id: root

    // End text
    Text {
        color: "#232629"
        text: qsTr("That's it!")
        font.weight: Font.Thin
        font.pixelSize: 72
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 70
    }



    Text {
        color: "#232629"
        text: qsTr("Reboot your phone\nto start plasma mobile")
        font.weight: Font.Thin
        font.pixelSize: 32
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 160
    }



    // Button to root and strat application of the content
    UI.Button {
        anchors.horizontalCenter: parent.horizontalCenter
        flat: true
        activateColor: "#bdc3c7"
        anchors.top: parent.top
        anchors.topMargin: parent.height - 70
        font.pixelSize: 21
        onClicked: function(){
            rebootProc.start("reboot", [], false);
        }

        contentItem: Text {
            color: "#3daee9"
            text: qsTr("Reboot phone")
            verticalAlignment: Text.AlignVCenter
            SequentialAnimation on color {
                loops: Animation.Infinite
                ColorAnimation { from: "#3daee9"; to: "#FFFFFF"; duration: 1000; easing.type: Easing.InOutQuad }
                ColorAnimation { from: "#FFFFFF"; to: "#3daee9"; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }        

    }

    Process {
        id: rebootProc
    }

    // Go back to default apps page.
    UI.Button {
        anchors.left: parent.left;
        anchors.leftMargin: 70
        flat: true
        activateColor: "#bdc3c7"
        anchors.top: parent.top
        anchors.topMargin: parent.height - 70
        font.pixelSize: 21
        onClicked: function(){
            root.goBack()
        }

        contentItem: Text {
            Image {
                anchors.top: parent.top
                anchors.right: parent.left
                sourceSize.width: 21;
                sourceSize.height: 21;
                source: "file:///usr/share/icons/breeze/actions/24/draw-arrow-back.svg"
            }
            color: "#000000"
            text: qsTr("Go back")
            verticalAlignment: Text.AlignVCenter
        }
    }
}
