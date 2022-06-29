 import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
import QtMultimedia 5.9
Scene {
    id:menuScene

    signal gameScenePressed

    signal gameScenePressed1

    property var imageList:["../assets/allbackgreen.png","../assets/allback.png","../assets/mpbg.png"]
    property int index: 0

    Image{

        anchors.fill: menuScene.gameWindowAnchorItem
        source: "../assets/background.png"
    }
    Image{
        x:gameScene.width
        y:0

        source: "../assets/logo.jpeg"
    }




//    Button{
//        width: 70
//        height: 50
//        anchors.centerIn: parent
//        Image {
//            id: playButton

//            source: "../assets/on.jpg"
//            anchors.fill:parent
//        }
//        onClicked: {
//            gameScenePressed()
//            menuMusic.stop()
//        }
//    }


    MediaPlayer{
        loops: SoundEffect.Infinite
        volume: 0.35
        id:menuMusic
        source: "../assets/Game.mp3"
        autoPlay: true


    }

    Rectangle{
        id:rec
        anchors.centerIn: parent
        Button{
            id:selectImage
            width: 200
            height: 200
            anchors.centerIn: parent
            Image{
                id:image1
                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                source:imageList[index]
                                width: 180
                                height: 180
            }
            onClicked: {
                            gameScene.setBackImage(image1.source)

//                            gameScenePressed()
                gameScenePressed1()
                            menuMusic.stop()
                        }
        }

        Button{
            id:leftSelect
            width: 30
            height: 30
            y:0
            flat:false
            icon.source: "../assets/leftSelect.png"
            icon.color: "transparent"
            icon.width: parent.width
            icon.height: parent.height
            anchors.right: selectImage.left
    //        Image {
    //            id: leftsSlectImage
    //            source: "../assets/leftSelect.png"
    //            anchors.fill: parent
    //        }

            onClicked: {

                index===0? index=2:index--
                image1.source=imageList[index]
            }
        }

        Button{
            id:rightSelect
            width: 30
            height: 30
            y:0
            flat:false
            anchors.left: selectImage.right
            Image{
                id:rightSelectImage
                source: "../assets/rightSelect.png"
                anchors.fill: parent
            }

            onClicked: {

                index===2? index=0:index++
                image1.source=imageList[index]
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
