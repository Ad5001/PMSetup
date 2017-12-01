import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2


Rectangle {
    width: 360
    height: 360
    id: root
    
    // Signal to switch page
    signal enterPin(string pin)

    // Up text
    Text {
        id: setupPinCodeText
        text: qsTr("Setup a pin code")
        font.weight: Font.Thin
        font.pixelSize: 72
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 70
        wrapMode: Text.WordWrap
    }

    // Input pin 
    TextField {
        id: inputPin
        // Input chars related
        validator: RegExpValidator { regExp: /\d{6}/ }
        inputMethodHints: Qt.ImhDigitsOnly
        echoMode: TextInput.Password
        // Design
        font.pixelSize: 50
        width: parent.width - (parent.width / 7)
        cursorVisible: false
        focus: true
        horizontalAlignment: TextInput.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        // Event listeners
        onTextEdited: if(inputPin.text.length == 6) {
            var pin = inputPin.text
            root.enterPin(inputPin.text);
            inputPin.clear();
        }
    }


    Text {
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#3daee9"
        text: "Pins do not match. Please renter a new pin"
    }
}
