import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/ui" as UI

Rectangle {
    
    width: 360
    height: 360
    id: root

    /**
     * Format:
     * - Name
     * - Bin file (to check if installed and launch)
     * - Icon file
     * - Package manager to install
     * - Package name
     */
    property var browsers: [
        [
            "Firefox Web Browser",
            "/usr/bin/firefox",
            "",
            "apt",
            "firefox"
        ],
        [
            "Chromium Web Browser",
            "/usr/bin/chromium-browser",
            "",
            "apt",
            "chromium-browser"
        ],
        [
            "Konqueror",
            "/usr/bin/konqueror",
            "",
            "apt",
            "konqueror"
        ],
        [
            "Midori",
            "/snap/bin/midori",
            "",
            "snap",
            "midori"
        ],
        [
            "QupZilla (changing name)",
            "/usr/bin/qupzilla",
            "",
            "apt",
            "qupzilla"
        ],
    ]
    


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

    
    // Default web browser
    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 160
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            anchors.left: parent.left
            text: qsTr("Web browser:")
            verticalAlignment: Text.AlignVCenter
            height: 37
            font.pixelSize: 18
        }
        UI.Button {
            id: defaultBrowserButton
            anchors.left: parent.left
            anchors.leftMargin: 120
            
            contentItem: Text {
                verticalAlignment: Text.AlignVCenter
                text: "Tap to choose"
                font.pixelSize: 18
            }
            onClicked: function(){
                popupBrowsers.opacity = 1
            }
            
        }
    }

    UI.SelectPopup {
        id: popupBrowsers
        title: "Web browser"
        contents: root.browsers
        opacity: 0

        onSelected: function(selection){
            root.browsers.forEach(function(elem){
                if(elem[1] == selection){
                    defaultBrowserButton.contentItem.text = elem[0];
                }
            })
        }
    }
}