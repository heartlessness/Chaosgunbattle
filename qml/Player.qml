import QtQuick 2.0
import Felgo 3.0
EntityBase {
    id:player
    entityType: "player"
    width: 30
    height: 30
    state: "walking"
    property Gun bullet
    property alias controller: control
    property alias inputActionsToKeyCode: control.inputActionsToKeyCode

    property alias boxcollider: boxcollider
    property int life: 10
    //readonly property real forwardForce: 800 * physicsWorld.pixelsPerMeter

    property alias horizontalVelocity: boxcollider.linearVelocity.x

    property int signal:0



    //    Image {
    //        id: image
    //        source: "../assets/Hero.png"
    //        anchors.fill: parent
    //        property list<Item> imagePoints: [

    //          Item {x: image.width/2+30}
    //        ]

    //    }

    //This is make gamer move
    TwoAxisController{
        id:control
        onInputActionPressed:
        {
            fire(actionName)
            move(actionName)
        }
        Keys.onEnterPressed: {fire("fire")}
        Keys.onUpPressed: {
            move("up")
        }
        Keys.onDownPressed: {
            move("down")
        }

        //        Keys.onUpPressed: boxcollider.linearVelocity.y-=250
        //        Keys.onDownPressed: player.y+=25

    }

    SpriteSequence{
        id:playeranimation

        defaultSource: "../assets/walking.png"
        scale: 1
        anchors.centerIn:boxcollider

        property list<Item> imagePoints:[
            Item{x:playeranimation.width/2+30}
        ]
        Sprite{
            name:"leftwalking"
            frameRate: 4
            frameCount: 1
            frameHeight: 67
            frameWidth: 64
            frameX: 0
            frameY:0
        }

        Sprite {
            name:"rightwalking"

            frameRate: 4
            frameHeight: 67
            frameWidth: 64
            frameCount: 1
            frameX: 64
            frameY:0
        }
        Sprite{
            name:"leftjumping"
            frameRate: 4
            frameHeight: 83
            frameWidth: 64
            frameCount: 3
            frameX: 128
            frameY: 0
        }
        Sprite{
            name:"rightjumping"
            frameRate: 4
            frameCount: 3
            frameHeight: 83
            frameWidth: 64
            frameX: 320
            frameY: 0
        }
    }

    BoxCollider{
        id:boxcollider

        force: Qt.point(control.xAxis*100*16, 0)
        torque: control.yAxis*200

        fixedRotation: true

        width: 60
        height: 60
        anchors.fill: parent
        //this is gamer density
        density: 0.002
        gravityScale: 1.1

        onLinearVelocityChanged: {
            if(linearVelocity.x > 170) linearVelocity.x = 170
            if(linearVelocity.x < -170) linearVelocity.x = -170
        }


        fixture.onContactChanged: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            if(otherEntityType==="border"){
                player.die()
            }
            if(otherEntity==="platform"){

            }

        }
    }


    Timer{
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis;
            // if xAxis is 0 (no movement command) we slow the player down until he stops
            if(xAxis === 0) {
                if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
                else player.horizontalVelocity = 0
            }
        }
    }

    function fire(action)
    {
        if(action==="fire")
        {
            var imagePointInWorldCoordinates = mapToItem(level,playeranimation.imagePoints[0].x, playeranimation.imagePoints[0].y)
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y,"rotation": playeranimation.rotation})
            console.log("actionName output")
        }
    }

    function die(){
        player.x=50
        player.y=0
        boxcollider.linearVelocity.y=0
        console.log("die")
    }



    function move(actionName){
        if(actionName==="up"&&player.state==="walking")
        {
            player.state="jumping"
            boxcollider.linearVelocity.y-=250


            if(signal==1){

                playeranimation.jumpTo("leftjumping")

            }
            if(signal==2)
            {
                playeranimation.jumpTo("rightjumping")
            }

        }

        if(actionName==="left")
        {
            playeranimation.jumpTo("leftwalking")

            signal=1
        }

        if(actionName==="right")
        {
            playeranimation.jumpTo("rightwalking")
            signal=2
        }

        if(actionName==="down")
        {

            player.y+=30
        }
    }
}

