import QtQuick 2.7
// import QtQuick.Dialogs 2.2
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

/**
 * Main Page class extended by all the pages
 *
 */
Rectangle {
    width: 360
    height: 360
    id: root
    color: white;
    border.width: 1
    border.color: "#DDDDDD"

    // Animations for in and out
    ParallelAnimation {
        id: enterAnimation
        NumberAnimation {
            target: root; 
            property: "anchors.leftMargin";
            from: parent.width / 2;
            to: 0; 
            duration: 200;
        }
        ScaleAnimator {
            target: root
            from: 0;
            to: 1;
            duration: 200
        }
        OpacityAnimator { 
            target: root
            from: 0; 
            to: 1; 
            duration: 200; 
        }
    }


    SequentialAnimation {
        id: exitAnimation
        ParallelAnimation {
            OpacityAnimator { 
                target: root
                from: 1; 
                to: 0; 
                duration: 200; 
            }
            NumberAnimation {
                target: root; 
                property: "anchors.leftMargin";
                from: 0; 
                to: parent.width / 2;
                duration: 200;
            }
            ScaleAnimator {
                target: root
                from: 1;
                to: 0;
                duration: 200
            }
        }
        ScriptAction { 
            script: function(){
                console.warn("Exiting2")
                root.z = -1;
                root.visible = false;
            } 
        }
    }

    function enter(){
        root.z = 13;
        root.visible = true;
        enterAnimation.start()
        enterAnimation.running = true;
    }

    function exit(){
        exitAnimation.start()
        exitAnimation.running = true;
    }
}
