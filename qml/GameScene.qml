import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
import QtMultimedia 5.9
Scene {
    id:gameScene
    width: 480
    height: 320
    gridSize: 32
    focus: true
    property int offsetBeforeScrollingStarts: 240
    signal menuScenePressed
    state:"start"
    property alias gameSceneOpen:gameScene




    ParallaxScrollingBackground {
        sourceImage: "../assets/allbackgreen.png"
        //anchors.fill: parent
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: Qt.point(0,0)
        ratio: Qt.point(0.6,0)
    }

    Rectangle{
        id:viewPort
        height: level.height
        width: level.width
        //anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x:0
        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            //debugDrawVisible: true // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if(entityB.entityType === "platform" && entityA.entityType === "player"
                        ) {
                    if(entityA.y + entityA.height > entityB.y)
                        contact.enabled = false
                    if(entityA.y + entityA.height < entityB.y)
                        entityA.state="walking"
                }
//                if(entityB.entityType === "border" && entityA.entityType === "player" && entityA.y + entityA.height < entityB.y)
//                {
//                    console.log("die")

//                    entityA.die()
//                }
            }
        }
        Level{
            id:level
        }
        Border{
            id:border
            x:-gameScene.width*2
            y:gameScene.height-10

        }


    }
    Keys.forwardTo: [gamer1.controller,gamer2.controller]
    Player{
        id:gamer1
        x:10
        y:10
    }

    Player{
        id:gamer2
        x:100
        y:100

        inputActionsToKeyCode: {
            "up": Qt.Key_W,
            "down": Qt.Key_S,
            "left": Qt.Key_A,
            "right": Qt.Key_D,
            "fire": Qt.Key_Space

        }

    }





//    Image{
//        width: 30
//        height: 30
//        id:infoText
//        //anchors.centerIn: parent
//         x:gameScene.width-30
//        source: gameScene.state=="gameOver" ? "../assets/button3.png" : "../assets/button1.png"
//        visible: gameScene.state!=="playing"
//    }



            Button{
                id: menuButton
                flat:true
                width: 30
                height: 30
                x:0
                Image{
                    anchors.fill: parent

                    source: "../assets/menu.png"
                }
                onClicked: {
                    menuScenePressed()
                    gameScene.state = "start"
                    console.log("click menu")

                }
            }

            Button{
                id:suspendButton
                width: 30
                height: 30
                flat:true

                x:gameScene.width-30
                Image{
                    anchors.fill: parent
                    source: "../assets/button3.png"
                }
                onClicked: {
                    physicsWorld.running=false
                    continueGame.visible=true
                }
            }

            Button{
                id:continueGame
                anchors.centerIn: parent
                width: 100
                height: 30
                visible: false
                Image{
                    anchors.fill: parent
                    source: "../assets/Continue1.jpg"
                }
                onClicked: {
                    physicsWorld.running=true
                    visible=false
                }
            }
}
