import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Process 1.0
import "qrc:/ui" as UI

UI.Page {
    
    width: 360
    height: 360
    id: root

    
    property var passcode: "unknown"; // Getting password
    
    property var console2: console
    

    signal installationStarted(Process proc)
    signal readyRead()
    signal installationEnded()
    
    

    /**
     * Format:
     * - Name
     * - Bin file (to check if installed and launch)
     * - Icon file
     */
    property var browsers: [
        [
            "Mozilla Firefox",
            "/usr/bin/firefox",
            "qrc:/icons/browser/firefox.svg",
            "firefox"
        ],
        [
            "Google Chromium",
            "/usr/bin/chromium-browser",
            "qrc:/icons/browser/chromium.png",
            "chromium-browser"
        ],
        [
            "Konqueror",
            "/usr/bin/konqueror",
            "qrc:/icons/browser/konqueror.svg",
            "konqueror"
        ],
        [
            "QupZilla (changing name)",
            "/usr/bin/qupzilla",
            "qrc:/icons/browser/qupzilla.png",
            "qupzilla"
        ],
    ]
    
    property var email_clients: [
        [
            "KMail",
            "/usr/bin/kmail",
            "qrc:/icons/email/kmail.svg",
            "kmail"
        ],
        [
            "Mozilla Thunderbird",
            "/usr/bin/thunderbird",
            "qrc:/icons/email/thunderbird.png",
            "thunderbird"
        ],
        [
            "Evolution",
            "/usr/bin/evolution",
            "qrc:/icons/email/evolution.svg",
            "evolution"
        ]
    ]
    
    property var music_players: [
        [
            "Cantata",
            "/usr/bin/cantata",
            "file:///usr/share/icons/breeze/apps/48/cantata.svg",
            "cantata"
        ],
        [
            "Rhythmbox",
            "/usr/bin/rhytmbox",
            "qrc:/icons/music/rhythmbox.svg",
            "rhythmbox"
        ],
    ]
    
    

    property var selectedBrowser: root.browsers[0];
    property var selectedEmail: root.email_clients[0];
    property var selectedMusic: root.music_players[0];
    
    


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
                popupBrowsers.visible = true
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
                    root.selectedBrowser = elem;
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
                popupEmail.visible = true
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
                    root.selectedEmail = elem;
                }
            })
        }
    }


    // Default music player
    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 280
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            anchors.left: parent.left
            text: qsTr("Music player:")
            verticalAlignment: Text.AlignVCenter
            height: 37
            font.pixelSize: 18
        }
        UI.Button {
            id: defaultMusicButton
            anchors.left: parent.left
            anchors.leftMargin: 120
            
            contentItem: Text {
                Image {
                    id: musicIcon
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    source: "file:///usr/share/icons/breeze/apps/48/cantata.svg"
                    sourceSize.width: 24;
                    sourceSize.height: 24;
                }
                id: musicName
                verticalAlignment: Text.AlignVCenter
                text: "       Cantata"
                font.pixelSize: 18
                
            }
            onClicked: function(){
                popupMusic.opacity = 1
                popupMusic.visible = true
            }
        }
    }

    UI.SelectPopup {
        id: popupMusic
        title: "Music player"
        contents: root.music_players
        opacity: 0

        onSelected: function(selection){
            root.music_players.forEach(function(elem){
                if(elem[1] == selection){
                    musicName.text = "       " + elem[0];
                    musicIcon.source = elem[2];
                    root.selectedMusic = elem;
                }
            })
        }
    }




    // Applying changes
    UI.Button {
        anchors.horizontalCenter: parent.horizontalCenter
        flat: true
        activateColor: "#bdc3c7"
        anchors.top: parent.top
        anchors.topMargin: parent.height - 70
        font.pixelSize: 21
        onClicked: function(){
            installProc.startInstall([selectedBrowser, selectedEmail, selectedMusic])
        }

        contentItem: Text {
            color: "#3daee9"
            text: qsTr("Apply changes")
            verticalAlignment: Text.AlignVCenter
            SequentialAnimation on color {
                loops: Animation.Infinite
                ColorAnimation { from: "#3daee9"; to: "#FFFFFF"; duration: 1000; easing.type: Easing.InOutQuad }
                ColorAnimation { from: "#FFFFFF"; to: "#3daee9"; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }
    }

    Process {
        id: installProc
        
        property var subprocFinished: false;
        
        
        function startInstall(configurations){
            var installs = [];
            configurations.forEach(function(elem){
                // fileExistsProc.start("/usr/bin/sh", ["-c", "\"(test " + elem[1] + " && echo F) || echo NF\""], false);
                // console.warn(fileExistsProc.readAll().toString());
                // while(!subprocFinished) console.warn(fileExistsProc.readAll().toString());
                // if(fileExistsProc.readAll().toString().indexOf("NF") !== -1) installs.push(elem[3]); // File not found, install the program
                installs.push(elem[3]);
            })
            console.warn("Installing " + installs.length, installs)
            if(installs.length > 0) {
                if(root.passcode !== "unknown"){
                    var args = ["apt-get", "install", "-y", "--no-install-recommends"];
                    configurations.forEach(function(elem){args.push(elem[3])})
                    this.start("/usr/bin/sudo", args, false);
                } else {
                    var args = ["--user", "root", "apt-get", "install", "-y", "--no-install-recommends"]
                    configurations.forEach(function(elem){args.push(elem[3])})
                    this.start("/usr/bin/pkexec", args, false);
                }
            }
        }
        onStarted: function(){
            if(root.passcode !== "unknown"){// Sudo, needs a password
                writeToStdin(root.passcode + "\n");
            }
            root.installationStarted(installProc)
        }
        onFinished: root.installationEnded()
        onReadyRead: root.readyRead()
        onReadyReadStandardOutput: root.readyRead();
    }


    Process {
        id: fileExistsProc
        onStarted: console.warn("Yay1", readAll().toString())
        onReadyRead: console.warn("Yay2", readAll().toString())
    }
}