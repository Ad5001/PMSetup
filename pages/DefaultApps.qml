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
            "Mozilla Firefox",
            "/usr/bin/firefox",
            "qrc:/icons/browser/firefox.svg",
            "apt",
            "firefox"
        ],
        [
            "Google Chromium",
            "/usr/bin/chromium-browser",
            "qrc:/icons/browser/chromium.png",
            "apt",
            "chromium-browser"
        ],
        [
            "Konqueror",
            "/usr/bin/konqueror",
            "qrc:/icons/browser/konqueror.svg",
            "apt",
            "konqueror"
        ],
        [
            "Midori",
            "/snap/bin/midori",
            "qrc:/icons/browser/midori.svg",
            "snap",
            "midori"
        ],
        [
            "QupZilla (changing name)",
            "/usr/bin/qupzilla",
            "qrc:/icons/browser/qupzilla.png",
            "apt",
            "qupzilla"
        ],
    ]
    
    property var email_clients: [
        [
            "KMail",
            "/usr/bin/kmail",
            "qrc:/icons/email/kmail.svg",
            "apt",
            "kmail"
        ],
        [
            "Mozilla Thunderbird",
            "/usr/bin/thunderbird",
            "qrc:/icons/email/thunderbird.png",
            "apt",
            "thunderbird"
        ],
        [
            "Evolution",
            "/usr/bin/evolution",
            "qrc:/icons/email/evolution.svg",
            "apt",
            "evolution"
        ]
    ]
    

    property var selectedBrowser: "/usr/bin/firefox";
    property var selectedEmail: "/usr/bin/kmail";
    
    


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
                Image {
                    id: browserIcon
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    source: "qrc:/icons/browser/firefox.svg"
                    sourceSize.width: 24;
                    sourceSize.height: 24;
                }
                id: browserName
                verticalAlignment: Text.AlignVCenter
                text: "       Mozilla Firefox"
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
                    browserName.text = "       " + elem[0];
                    browserIcon.source = elem[2];
                    root.selectedBrowser = elem[1];
                }
            })
        }
    }

    // Default email client
    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 220
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            anchors.left: parent.left
            text: qsTr("Email client:")
            verticalAlignment: Text.AlignVCenter
            height: 37
            font.pixelSize: 18
        }
        UI.Button {
            id: defaultEmailButton
            anchors.left: parent.left
            anchors.leftMargin: 120
            
            contentItem: Text {
                Image {
                    id: emailIcon
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    source: "qrc:/icons/email/kmail.svg"
                    sourceSize.width: 24;
                    sourceSize.height: 24;
                }
                id: emailName
                verticalAlignment: Text.AlignVCenter
                text: "       KMail"
                font.pixelSize: 18
                
            }
            onClicked: function(){
                popupEmail.opacity = 1
            }
        }
    }

    UI.SelectPopup {
        id: popupEmail
        title: "Email client"
        contents: root.email_clients
        opacity: 0

        onSelected: function(selection){
            root.email_clients.forEach(function(elem){
                if(elem[1] == selection){
                    emailName.text = "       " + elem[0];
                    emailIcon.source = elem[2];
                    root.selectedEmail = elem[1];
                }
            })
        }
    }
}