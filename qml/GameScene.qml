import QtQuick 2.0
import Felgo 3.0
Scene {
    id:gameScene
    width: 480
    height: 320
    gridSize: 32
    focus: true
    property int offsetBeforeScrollingStarts: 240




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
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
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
            if(entityB.entityType === "platform" && entityA.entityType === "player" &&
                entityA.y + entityA.height > entityB.y) {
              //by setting enabled to false, they can be filtered out completely
              //-> disable cloud platform collisions when the player is below the platform
              contact.enabled = false
            }
          }
        }
        Level{
            id:level
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


}
