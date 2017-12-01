import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

// Background
Rectangle {
    id: root
    width: parent.width
    height: parent.height
    color: "#80000000"
    visible: true

    // When an option is selected
    signal selected(string nameSelected)
    
    // Close animation
    PropertyAnimation { 
        id: closeAnimation
        target: root; 
        property: "opacity"; 
        to: 0 
        duration: 400
        easing.type: Easing.InOutQuad
    }
    

    property string title: ""
    property var contents: []

    // Real popup
    Rectangle {
        id: realPopup
        color: "white"
        width: parent.width * 0.75
        height: parent.height * 0.75
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: (parent.height * 0.25) / 2;
        anchors.leftMargin: (parent.width * 0.25) / 2;

        // Padding
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 20
            anchors.leftMargin: 20

            // Title
            Text {
                width: (parent.width * 0.25) / 2 - 40
                wrapMode: Text.WordWrap
                font.weight: Font.Thin
                font.pixelSize: 50
                text: root.title
            }

            // Showing button list 
            Component {
                id: buttonListShow
                Button {
                    width: (parent.width * 0.75) - 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 15
                    flat: true

                    onClicked: function(){
                        // clickedAnimation.running = true
                        root.selected(selectionId)
                        closeAnimation.running = true
                    }

                    contentItem: Text {
                        text: qsTr(title)
                        verticalAlignment: Text.AlignVCenter
                    }

                }
            }
        }
        
    }

    // Popup shadow
    DropShadow {
        anchors.fill: realPopup
        horizontalOffset: 2
        verticalOffset: 2
        radius: 40.0
        samples: 17
        color: "#80000000"
        source: realPopup
    }

    // List
    ListModel {
        id: buttonsList
        Component.onCompleted: function(){
            root.contents.forEach(function(elem){
                buttonsList.append({"title": elem[0], "selectionId": elem[1]})
                console.warn("Adding elem: " + JSON.stringify(elem))
                
            })
        }
        
    }

    // Manager
    ListView {
        anchors.top: parent.top
        anchors.topMargin: (parent.height * 0.25) / 2 + 95;
        anchors.left: parent.left
        anchors.fill: parent
        model: buttonsList
        delegate: buttonListShow
    }
}
