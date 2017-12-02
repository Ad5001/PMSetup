import QtQuick 2.7
import QtQuick.Controls 2.2

import "qrc:/ui/Progress"

Rectangle {
    id: root
    height: parent.height
    anchors.leftMargin: root.width - (3 * 80 - 60); // 3 balls, removing the last bar (60) and removing the right margin)
    
    
    property var stepsComponents: [[step0Link, step0Bubble], [step1Link, step1Bubble], [step2Link, step2Bubble]]
    

    
    function updateBar(select) {
        select = parseInt(select)
        for(var i = 2; i > 0; i--){
            if(select < i && root.stepsComponents[i][0].active){
                root.stepsComponents[i][0].active = false
                root.stepsComponents[i][1].active = false
            } else if(select >= i) {
                root.stepsComponents[i][0].active = true
                root.stepsComponents[i][1].active = true
            }
        }
    }

    // Step 0, Welcome
    ProgressLink {
        id: step0Link
        anchors.top: parent.top
        anchors.topMargin: 24
        visible: false
    }
    ProgressBubble {
        id: step0Bubble
        anchors.top: parent.top
        anchors.topMargin: 16
        text: "Welcome"
        active: true
    }
    // Step 1, Setup pin
    ProgressLink {
        id: step1Link
        anchors.left: step0Bubble.right
        anchors.top: parent.top
        anchors.topMargin: 24
    }
    ProgressBubble {
        anchors.left: step1Link.right
        id: step1Bubble
        anchors.top: parent.top
        anchors.topMargin: 16
        text: "Setup pin"
    }
    // Step 2, Default apps
    ProgressLink {
        id: step2Link
        anchors.left: step1Bubble.right
        anchors.top: parent.top
        anchors.topMargin: 24
    }
    ProgressBubble {
        anchors.left: step2Link.right
        id: step2Bubble
        anchors.top: parent.top
        anchors.topMargin: 16
        text: "Default apps"
    }


}