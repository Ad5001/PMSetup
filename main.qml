import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Process 1.0
import "pages" as Page
import "js/pages.js" as PageSwitcher

Window {

    
    property string enteredPin;
    property bool isPinSet: true;
    property string currentUsername;
    
    
    id: mainWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight -100
    x: 0
    y: 0
    title: qsTr("Plasma Mobile Setup")

    // Processes for setting pin up.
    Process {
        id: processIsPinSet
        onFinished: function(){
            var text = readAll().toString().split(" ");
            if(text[1] == "NP") mainWindow.isPinSet = false;
            mainWindow.currentUsername = text[0];
        }
    }

    Process {
        id: processSetPin
        onStarted: function(){
            writeToStdin(mainWindow.enteredPin + "\n")
            writeToStdin(mainWindow.enteredPin + "\n")
            waitForFinished();
            PageSwitcher.switchPage(5)
        }
    }

    // Start page

    Page.StartPage {
        id: startPage
        anchors.fill: parent
        visible: true
        z: 1
        onSwitchPage: function(pageId){
            processIsPinSet.start("/usr/bin/passwd", [ "--status" ], true);
            if(mainWindow.isPinSet){
                PageSwitcher.switchPage(pageId + 3);
                // PageSwitcher.switchPage(pageId);
            } else {
                PageSwitcher.switchPage(pageId);
            }
        }
    }

    //Pin setup related

    Page.SetupPin {
        anchors.fill: parent
        id: setupPinPage
        visible: false
        z: -1;
        onEnterPin: function(pin) {
            mainWindow.enteredPin = pin;
            PageSwitcher.switchPage(2);
        }
        // onSwitchPage: PageSwitcher.switchPage(pageId);
    }

    Page.VerifyPin {
        anchors.fill: parent
        id: verifyPinPage
        visible: false
        z: -1;
        onEnterPin: function(pin) { //
            if(pin !== mainWindow.enteredPin){ // Wrong pin
                PageSwitcher.switchPage(3);
            } else { // Next page
                processSetPin.start("/usr/bin/passwd", [mainWindow.currentUsername], false);
                processSetPin.readAll();
            }
        }
    }
    
    Page.IncorrectPin {
        anchors.fill: parent
        id: incorrectPinPage
        visible: false
        z: -1;
        onEnterPin: function(pin) {
            mainWindow.enteredPin = pin;
            PageSwitcher.switchPage(2);
        }
    }


    function startupFunction() {
        PageSwitcher.init([startPage, setupPinPage, verifyPinPage, incorrectPinPage], startPage);
    }
    Component.onCompleted: startupFunction();
}
