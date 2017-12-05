import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import Process 1.0
import "qrc:/ui" as UI

UI.Page {
    
    property var selectedLang: "en";
    
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

    // Select language popup
    UI.SelectPopup {
        visible: false
        id: selectLanguagePopup
        /**
         * Gets the XML language file and checks for all the languages, then saves it as a global.
         */
        Process {
            id: getLanguagesProc
            onFinished: function(){
                var rawLayoutsList = (new DOMParser()).parseFromString(readAll(), "text/xml")[2].childNodes[0].childNodes; // Currently layoutList>layout>*
                var layoutsList = {};
                rawLayoutsList.forEach(function(langConfig){
                    // Defining an easily readable 
                    langConfig.configItem.name = {
                        "displayName": langConfig.configItem.description,
                        "variants": langConfig.variantList
                    }
                })
                // TODO: Put this as buttons and use a command to set it as default language with a popup
            }
        }
    }


    // Button to start setup
    UI.Button {
        anchors.horizontalCenter: parent.horizontalCenter
        flat: true
        activateColor: "#bdc3c7"
        anchors.top: parent.top
        anchors.topMargin: parent.height - 70
        font.pixelSize: 21
        onClicked: function(){
            root.switchPage(1);
        }

        contentItem: Text {
            color: "#3daee9"
            text: qsTr("Tap to start setuping your phone")
            verticalAlignment: Text.AlignVCenter
            SequentialAnimation on color {
                loops: Animation.Infinite
                ColorAnimation { from: "#3daee9"; to: "#FFFFFF"; duration: 1000; easing.type: Easing.InOutQuad }
                ColorAnimation { from: "#FFFFFF"; to: "#3daee9"; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }        

    }
}
