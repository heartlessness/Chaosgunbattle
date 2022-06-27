import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.9
EntityBase {
    id:player
    entityType: "player"
    width: 30
    height: 30

    property Gun bullet
    property alias controller: control
    property alias inputActionsToKeyCode: control.inputActionsToKeyCode

    property alias boxcollider: boxcollider
    property int life: 5

    //readonly property real forwardForce: 800 * physicsWorld.pixelsPerMeter

    property alias horizontalVelocity: boxcollider.linearVelocity.x

    property int signal: 0

    SpriteSequence{
        id:playeranimation
        defaultSource: "../assets/walking.png"
        scale: 1
        anchors.fill: boxcollider

        property list<Item> imagePoints: [

          Item {x: playeranimation.width/2+30}
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

    //This is make gamer move
    TwoAxisController{
        id:control

        property int i: 0

        onInputActionPressed:
        {

            fire(actionName)
            i=move(actionName)

        }


        Keys.onEnterPressed: {fire("fire")}

        Keys.onUpPressed:{
            move("up")
        }

        Keys.onDownPressed:
        {
            move("down")
        }

        Keys.onReleased: {
            if(i===1)
                playeranimation.jumpTo("leftwalking")
            if(i===2)
                playeranimation.jumpTo("rightwalking")
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


    BoxCollider{
        id:boxcollider

        force: Qt.point(control.xAxis*100*16, 0)
        //torque: control.yAxis*20

        fixedRotation:true

        width: 60
        height: 60
        anchors.fill: parent

        //this is gamer density
        density: 0.001
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
                player.life--


            }

        }
    }

    MediaPlayer{
        loops:SoundEffect.Infinite
        volume: 0.35
        id:gunMusic
        source: "../assets/fire.mp3"
        autoPlay: false
    }




    function fire(action)
    {
        if(action==="fire")
        {
            gunMusic.play()


            if(signal==1)
           {
                var imagePointInWorldCoordinates = mapToItem(level,playeranimation.imagePoints[0].x-65, playeranimation.imagePoints[0].y+15)

             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y,"rotation": boxcollider.rotation})
            console.log("fired")
                }

            if(signal==2)
            {
                var imagePointInWorldCoordinates1 = mapToItem(level,playeranimation.imagePoints[0].x-5, playeranimation.imagePoints[0].y+15)

             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates1.x, "y": imagePointInWorldCoordinates1.y,"rotation": boxcollider.rotation})
            console.log("fired")
            }

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
            boxcollider.rotation=180
        }

        if(actionName==="right")
        {
            playeranimation.jumpTo("rightwalking")
            signal=2
            boxcollider.rotation=0
        }

        if(actionName==="down")
        {

            player.y+=30
        }
        return signal
    }

}

