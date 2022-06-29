import QtQuick 2.0
import Felgo 3.0
EntityBase {
    id:randGun
    entityType: "randGun"

    property int bulletPower: 100
    property alias rand: randGun
    function bulletPower1(){
        return bulletPower
    }




    BoxCollider{
        id:boxcollider
        width: 30
        height: 30

        density: 0.001
        body.fixedRotation: true

        fixture.onBeginContact: {
            var fixture=other
            var body =other.getBody()
            var otherEntity =body.target
            var colliderType =otherEntity.entityType

            if(colliderType==="player")
            {

                randGun.removeEntity()
            }

        }
        Image{
            id:randGunImage
//            width: 30
//            height: 30
            anchors.fill:parent
            source: "../assets/M4A1.png"

        }

    }



    function setRandGunImage(str){
        randGunImage.source=str
    }

}
