import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
import QtMultimedia 5.9
Scene {
    id:menuScene

    signal gameScenePressed

    Image{

        anchors.fill: menuScene.gameWindowAnchorItem
        source: "../assets/background.png"
    }
    Image{
        x:gameScene.width
        y:0

        source: "../assets /logo.jpeg"
    }




    Button{
        width: 70
        height: 50
        anchors.centerIn: parent
        Image {
            id: playButton

            source: "../assets/on.jpg"
            anchors.fill:parent
        }
        onClicked: {
            gameScenePressed()
            menuMusic.stop()
        }
    }

    MediaPlayer{
        loops: SoundEffect.Infinite
        volume: 0.35
        id:menuMusic
        source: "../assets/Game.mp3"
        autoPlay: true


    }

    GridView{
        id:grid
        anchors.fill: parent
        cellHeight: 200
        cellWidth: 200
        anchors.margins: 20
        model:ListModel{
            id:model

            ListElement{
                src:"../assets/allbackgreen.png"
                width1:200
                height1:200
            }
            ListElement{
                src:"../assets/allback.png"
                width1:200
                height1:200
            }
            ListElement{
                src:"../assets/mpbg.png"
                width1:200
                height1:200
            }
        }
        delegate: Button{
            id:rec
            width: grid.cellWidth
            height: grid.cellHeight

            Image{
                id:image1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source:model.src
                width: grid.cellWidth*0.9
                height: grid.cellHeight*0.9
            }
            onClicked: {
                gameScene.setBackImage(src)
                gameScenePressed()
                menuMusic.stop()
            }

        }
    }

    function playMenuMusic(){
        menuMusic.play()
    }

    function pauseMenuMusic(){
        menuMusic.stop()
    }




}
