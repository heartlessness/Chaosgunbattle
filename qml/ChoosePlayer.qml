import QtQuick 2.0
 import Felgo 3.0
import  QtQuick.Controls 2.0
Scene {
    id:chooseplayer


    signal gameScenePressed1

    signal gameScenePressed2


    Image {
        width: gameScene.width
        height: gameScene.height
        id: background
        source: "../assets/allbackgreen.png"
    }

    Button{
        x:0
        y:20
        id:back
        width: 20
        height: 20
        flat:true

        Image {
            anchors.fill:parent

            id: backoff
            source: "../assets/again2.png"

        }

        onClicked: {
            gameScenePressed1()
        }
    }

    Button{
        id:con


        flat:true
        x:420
        y:20

        width: 20
        height: 20

        Image {
            anchors.fill: parent
            id: jixu
            source: "../assets/continue.png"
        }

        onClicked: {
            gameScenePressed2()
        }
    }

    Image{
        id:choose1

        x:90
        y:180

        width: 30
        height: 50
    }

    GridView{

        x:50
        y:270

        height: 40
        width: 200
        cellHeight: 40
        cellWidth:40



       model: ListModel{
           id:model
           ListElement{
               src1:"../assets/mon1.png"
               src2:"../assets/monster.png"
               defaultsource:"../assets/yemanspritesheet.png"

               width:20
               height:40
           }
           ListElement{
               src1:"../assets/mon2.png"
               src2:"../assets/monster2.png"

               defaultsource:"../assets/redspritesheet.png"

               width:20
               height:40
           }
           ListElement{
               src1:"../assets/Hero1.png"
               src2:"../assets/Hero.png"

               defaultsource:"../assets/bulespritesheet.png"

               width:20
               height:40
           }
       }
       delegate: Button{
           width:40
           height: 40
           Image {
               id: image

               anchors.fill:parent


               source: model.src1
           }
           onClicked: {
            choose1.source=model.src2
            gameScene.player1.sequence.defaultSource=model.defaultsource;



       }
    }

}
    Image {
        id: choose2
        x:330
        y:190

        width: 30
        height: 50

    }
    GridView{

        x:300
        y:270

        height: 40
        width: 200
        cellHeight: 40
        cellWidth:40


       model: ListModel{
           id:model1

           ListElement{
               src1:"../assets/mon1.png"
               src2:"../assets/monster.png"
               defaultsource:"../assets/yemanspritesheet.png"

               width:20
               height:40
           }
           ListElement{
               src1:"../assets/mon2.png"
               src2:"../assets/monster2.png"

               defaultsource:"../assets/redspritesheet.png"

               width:20
               height:40
           }
           ListElement{
               src1:"../assets/Hero1.png"
               src2:"../assets/Hero.png"

               defaultsource:"../assets/bulespritesheet.png"

               width:20
               height:40
           }
       }
       delegate: Button{
           width:40
           height: 40
           Image {
               id: image1

               anchors.fill:parent

               source: model.src1
           }
           onClicked: {
           choose2.source=model.src2
           gameScene.player2.sequence.defaultSource=model.defaultsource

       }
    }

}
}
