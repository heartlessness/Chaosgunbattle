import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.9
EntityBase {
    id:player
    entityType: "player"
    width: 30
    height: 30

    state: "left"

    property int number: 0

    property Gun bullet
    property alias controller: control
    property alias inputActionsToKeyCode: control.inputActionsToKeyCode

    property alias boxcollider: boxcollider

    property alias sequence: playeranimation

    property int life: 5

    //readonly property real forwardForce: 800 * physicsWorld.pixelsPerMeter

    property alias horizontalVelocity: boxcollider.linearVelocity.x

    property int signal: 0

    property var str1: "../assets/handgun2.png"
    property var str2: "../assets/handgun.png"
    property var gunKinds: "handgun"
    property int gunPower: 150


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
            {
                playeranimation.jumpTo("leftwalking")
                gunImage.rotation=-30
            }
            if(i===2)
            {

                playeranimation.jumpTo("rightwalking")
                gunImage.rotation=30

            }

            boxcollider.collidesWith=Box.Category1|Box.Category2
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
    Rectangle{
        id:playerNumber
        x:-10
        y:-20

        border.color: "transparent"
        Text {
            id: name
            font.family: "../assets/Marker Felt.ttf"
            font.pointSize: 10
            text: qsTr("player"+player.number)
        }
    }
    Rectangle{
        id:gunRec
        width: 15
        height: 15
        x:boxcollider.x-10
        y:boxcollider.y+10
        border.color: "transparent"
        color: "transparent"


        Image{
            id:gunImage
            anchors.fill: parent
            rotation: -30


            source: "../assets/handgun2.png"
        }
    }



    BoxCollider{
        id:boxcollider

        force: Qt.point(control.xAxis*100*16, 0)
        //torque: control.yAxis*20

        categories:Box.Category3
        collidesWith: Box.Category1|Box.Category2

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

            if(otherEntityType==="randGun")
                setRandGunImage("../assets/M4A1(left).png","../assets/M4A1.png")

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
            gunImage.rotation=0


            if(signal==1)
            {
                var imagePointInWorldCoordinates = mapToItem(level,playeranimation.imagePoints[0].x-65, playeranimation.imagePoints[0].y+11)

                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y,"rotation": boxcollider.rotation,"power":player.gunPower})
                console.log("fired")
            }

            if(signal==2)
            {
                var imagePointInWorldCoordinates1 = mapToItem(level,playeranimation.imagePoints[0].x-5, playeranimation.imagePoints[0].y+11)

                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates1.x, "y": imagePointInWorldCoordinates1.y,"rotation": boxcollider.rotation,"power":player.gunPower})
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
            if(player.gunKinds==="handgun"){
                gunRec.x=boxcollider.x-10
                gunRec.y=boxcollider.y+10
            }
            if(player.gunKinds==="M4A1"){
                gunRec.x=boxcollider.x-18
                gunRec.y=boxcollider.y+2
            }

            gunImage.source=player.str1

            gunImage.rotation=-30
            //gunImage.rotation=180

        }

        if(actionName==="right")
        {
            playeranimation.jumpTo("rightwalking")
            signal=2
            boxcollider.rotation=0
            if(player.gunKinds==="handgun"){
                gunRec.x=boxcollider.x+15
                gunRec.y=boxcollider.y+8
            }
            if(player.gunKinds==="M4A1"){
                gunRec.x=boxcollider.x+8
                gunRec.y=boxcollider.y+2
            }


            gunImage.rotation=30
            gunImage.source=player.str2
        }

        if(actionName==="down")
        {

            boxcollider.collidesWith=Box.Category1
        }
        return signal
    }

    function setRandGunImage(str1,str2){
        player.str1=str1
        player.str2=str2
        player.gunKinds="M4A1"
        player.gunPower=300
        gunRec.width=30
        gunRec.height=20


    }

}

