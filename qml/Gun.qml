import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:gun
    entityType: "Gun"


    property real angleDeg
    property RandGun rand

    property int power: 150

    rotation: angleDeg

    Component.onCompleted: {
        console.log("bullet is fired")
        apply();
    }
    BoxCollider {

        id:boxcollider
        width: 10
        height: 20
        gravityScale: 0

        categories:Box.Category1
        collidesWith: Box.Category3



        anchors.centerIn:parent

        density: 0.001

        body.bullet: true
        body.fixedRotation: true

        fixture.onBeginContact: {
            var fixture=other;
            var body=other.getBody();
            var otherEntity=body.target

            var colliderType=otherEntity.entityType

            if(colliderType==="player" ||colliderType==="Gun"||colliderType==="platform")
            {
                gun.removeEntity()

            }






//            var normalAngle = 180 / Math.PI * Math.atan2(contactNormal.y, contactNormal.x)
//            var angleDiff = normalAngle - gun.rotation
//            var newAngle = gun.rotation + 2 * angleDiff + 180

//            gun.rotation=newAngle

 //           boxcollider.body.linearVelocity=Qt.point(0,0)

            apply()
            }
            }


    Image {
        id: bullet1
        source: "../assets/bullet.png"
        anchors.centerIn: parent
        width:20
        height: 10

    }
    function apply()
    {

        var rad = gun.rotation / 180 * Math.PI


        var localForward = Qt.point(gun.power * Math.cos(rad), gun.power * Math.sin(rad))
        boxcollider.body.applyLinearImpulse(localForward, boxcollider.body.getWorldCenter())
    }
}
