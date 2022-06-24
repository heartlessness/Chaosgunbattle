import QtQuick 2.0
import Felgo 3.0
EntityBase {
    id:border
    entityType: "border"




    BoxCollider{
        width: gameScene.width*5
        height:50
        bodyType: Body.Static
        //collisionTestingOnlyMode: true

        Rectangle{
            anchors.fill: parent
            color: "red"
            visible: false
        }
    }

}
