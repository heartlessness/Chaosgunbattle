import QtQuick 2.0
import Felgo 3.0
EntityBase {
    id:player
    entityType: "player"
    width: 30
    height: 30

    property Gun bullet
    property alias controller: control
    property alias inputActionsToKeyCode: control.inputActionsToKeyCode

    property alias boxcollider: boxcollider
    property int life: 10
    //readonly property real forwardForce: 800 * physicsWorld.pixelsPerMeter

    property alias horizontalVelocity: boxcollider.linearVelocity.x

    property int single:0

    Image {
        id: image
        source: "/Chaosgunbattle/assets/Hero.png"
        anchors.fill: parent
        property list<Item> imagePoints: [

          Item {x: image.width/2+30}
        ]

    }

    //This is make gamer move
    TwoAxisController{
        id:control
        onInputActionPressed:
        {
            fire(actionName)
            if(actionName==="up")
                boxcollider.linearVelocity.y-=250
            if(actionName==="down")
                player.y+=20
        }
        Keys.onEnterPressed: {fire("fire")}
        Keys.onUpPressed: boxcollider.linearVelocity.y-=250
        Keys.onDownPressed: player.y+=25

    }


    BoxCollider{
        id:boxcollider

        force: Qt.point(control.xAxis*25*25, 0)
        torque: control.yAxis*200

       fixedRotation: true

        width: 60
        height: 40
        anchors.fill: parent
        //this is gamer density
        density: 0.002
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
            var imagePointInWorldCoordinates = mapToItem(level,image.imagePoints[0].x, image.imagePoints[0].y)
             entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Gun.qml"), {"x":imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y,"rotation": player.rotation})
            console.log("actionName output")
        }
    }
}
