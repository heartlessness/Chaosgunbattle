import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
Scene {
    id:menuScene

    signal gameScenePressed

    Image{
        anchors.fill: menuScene.gameWindowAnchorItem
        source: "../assets/background.png"
    }

    Button{
        anchors.centerIn: parent
        Image {
            id: playButton

            source: "../assets/on.jpg"
            anchors.fill:parent
        }
        onClicked: {
            gameScenePressed()
            console.log("click")
        }
    }




}
