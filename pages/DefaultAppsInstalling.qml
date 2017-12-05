import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/ui" as UI

UI.Page {

    width: 360
    height: 360
    id: root

    
    property var proc: undefined; // Process for the installation

    
    property var stateOfPackage: [];

    
    property var states: [
        "Downloading",
        "Unpacking",
        "Configuring",
        "Configuring", // Sometimes a second one appears
    ]
    

    // initializing the proc
    function onReadyRead() {
        var text = root.proc.readAll().toString().split(/(\n|\r)+/);
        var match = / ([\w\d-:._]+) \([\w\d-:._]+\) ...$/gi.exec(text[0]);
        if(match){
            if(!root.stateOfPackage[match[1]]) root.stateOfPackage[match[1]] = 0;
            root.stateOfPackage[match[1]]++;
            statusText.text = states[root.stateOfPackage[match[1]]] + " package " + match[1];
        } else {
            var match2 = / ([\w\d-:._]+) [\w\d]+ [\w\d-.:_]+ \[(\d{1,3} )+[kMmGg]?B\]$/gi.exec(text[0]);
            if(match2) {
                root.stateOfPackage[match2[1]] = 0
                statusText.text = states[root.stateOfPackage[match[1]]] + " package " + match2[1];
            } else {
                var match3 = /^Err/gi.exec(text[0]);
                if(match3){
                    statusText.text = "Error: could not fetch packages.\nAre you connected to the internet?"
                }
            }
        }
    }
    

    // Up text
    Text {
        color: "#232629"
        text: qsTr("Default apps")
        font.weight: Font.Thin
        font.pixelSize: 72
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 70
        wrapMode: Text.WordWrap
    }


    // Current text
    Text {
        id: statusText
        color: "#232629"
        text: qsTr("Downloading packages...")
        font.weight: Font.Thin
        font.pixelSize: 23
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 200
        wrapMode: Text.WordWrap
    }
}