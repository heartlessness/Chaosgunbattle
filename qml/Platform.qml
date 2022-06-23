import QtQuick 2.0
import Felgo 3.0

    EntityBase{
        property int column: 0
        property int row: 0
        property int size // gets set in Platform.qml and Ground.qml

        // instead of directly modifying the x and y values of your tiles, we introduced rows and columns for easier positioning, have a look at Level1.qml on how they are used
        x: row*gameScene.gridSize
        y: level.height - (column+1)*gameScene.gridSize
        width: gameScene.gridSize * size
        height: gameScene.gridSize
        size:2
        entityType: "platform"

        Row{
            id:tileRow
            Tile{
                pos: "left"
                Image {
                    id: name0
                    source: "../assets/left.png"
                }
            }
            Repeater{
                model:size-2
                Tile{
                    pos: "mid"
                    Image {
                        id: name1
                        source: "../assets/mid" + index%2 + ".png"
                    }
                }
            }
            Tile{
                pos: "right"
                Image {
                    id: name2
                    source: "../assets/right.png"
                }
            }
        }

        BoxCollider{
            id:collider
            anchors.fill:parent
            bodyType: Body.Static

            fixture.onBeginContact: {
                var otherEntity = other.getBody().target
                if(otherEntity.entityType === "player") {
                  console.debug("contact platform begin")

                  // increase the number of active contacts the player has
                  player.contacts++
                }
            }

            fixture.onEndContact: {
              var otherEntity = other.getBody().target
              if(otherEntity.entityType === "player") {
                console.debug("contact platform end")

                // if the player leaves a platform, we decrease its number of active contacts
                player.contacts--
              }
        }
    }
}


