import QtQuick 2.7
import QtQuick.Controls 2.2

Button {
    id: root;

    
    property color activateColor: "#93cee9";
    
    
    

    background: Rectangle {
        radius: 3.5
        color: flat ? "#ffffff" : "#fcfcfc"


        ColorAnimation on color { 
            id: bgColorSetOff; 
            to: root.flat ? "#ffffff" : "#fcfcfc"; 
            duration: 400; 
            // easing.type: Easing.InOutQuad 
        }

        ColorAnimation on color { 
            id: bgColorSetOn; 
            to: activateColor; 
            duration: 400;
            // easing.type: Easing.InOutQuad;
        }
    }
    
    onPressed: bgColorSetOn.running = true;
    onClicked: bgColorSetOff.running = true;
}