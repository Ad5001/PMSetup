import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import Process 1.0
import "pages" as Page
import "js/pages.js" as PageSwitcher
import "ui/Progress" as Progress

ApplicationWindow {

    
    property string enteredPin;
    property bool isPinSet: true;
    property string currentUsername;
    
    
    id: mainWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    x: 0
    y: 0
    title: qsTr("Plasma Mobile Setup")
    color: "#fcfcfc"

    // Top Header
    header: Rectangle {
        visible: false
        width: parent.width
        height: 64
        color: "#bdc3c7"

        Image {
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.left: parent.left
            anchors.leftMargin: 16
            id: headerImage
            sourceSize.width: 40;
            sourceSize.height: 40;
            source: "/usr/share/icons/breeze/actions/24/draw-star.svg"
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 72
            id: headerText
            verticalAlignment: Text.AlignVCenter
            height: parent.height
            text: "Welcome"
            font.pixelSize: 20
        }

        property var icon: headerImage
        property var text: headerText

        Progress.ProgressBar {
            id: progressBar
            color: "#bdc3c7"
            anchors.left: headerText.right
            width: parent.width - headerText.width - 76
        }
        property var progressbar: progressBar
    }
    

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
            PageSwitcher.switchPage("defaultApps")
        }
    }

    // Start page

    Page.StartPage {        
        property string stepName: "Welcome"
        property string stepIcon: "/usr/share/icons/breeze/actions/24/draw-star.svg"
        property int stepId: 0
        
        
        id: startPage
        anchors.fill: parent
        visible: true
        z: 1
        color: "#fcfcfc"
        onSwitchPage: function(pageId){
            processIsPinSet.start("/usr/bin/passwd", [ "--status" ], true);
            if(mainWindow.isPinSet){
                PageSwitcher.switchPage("defaultApps");
            } else {
                PageSwitcher.switchPage("pin");
            }
        }
    }

    //Pin setup related
    Page.SetupPin {
        property string stepName: "Setup pîn"
        property string stepIcon: "/usr/share/icons/breeze/actions/24/object-locked.svg"
        property int stepId: 1

        anchors.fill: parent
        id: setupPinPage
        visible: false
        z: -1;
        color: "#fcfcfc"
        onEnterPin: function(pin) {
            mainWindow.enteredPin = pin;
            PageSwitcher.switchPage("pin2");
        }
        // onSwitchPage: PageSwitcher.switchPage(pageId);
    }

    Page.VerifyPin {
        property string stepName: "Setup pîn"
        property string stepIcon: "/usr/share/icons/breeze/actions/24/object-locked.svg"
        property int stepId: 1
        anchors.fill: parent
        id: verifyPinPage
        visible: false
        z: -1;
        color: "#fcfcfc"
        onEnterPin: function(pin) { //
            if(pin !== mainWindow.enteredPin){ // Wrong pin
                PageSwitcher.switchPage("pin3");
            } else { // Next page
                processSetPin.start("/usr/bin/passwd", [mainWindow.currentUsername], false);
                processSetPin.readAll();
            }
        }
    }
    
    Page.IncorrectPin {
        property string stepName: "Setup pîn"
        property string stepIcon: "/usr/share/icons/breeze/actions/24/object-locked.svg"
        property int stepId: 1
        anchors.fill: parent
        id: incorrectPinPage
        visible: false
        z: -1;
        color: "#fcfcfc"
        onEnterPin: function(pin) {
            mainWindow.enteredPin = pin;
            PageSwitcher.switchPage("pin2");
        }
    }
    
    Page.DefaultApps {
        property string stepName: "Default applications"
        property string stepIcon: "/usr/share/icons/breeze/actions/24/gtk-execute.svg"
        property int stepId: 2
        color: "#fcfcfc"
        anchors.fill: parent
        id: defaultAppsPage
        visible: false
        z: -1;
    }


    function startupFunction() {
        PageSwitcher.init({start: startPage, pin: setupPinPage, pin2: verifyPinPage, pin3: incorrectPinPage, defaultApps: defaultAppsPage}, startPage, mainWindow.header);
    }
    Component.onCompleted: startupFunction();
}
