import Felgo 3.0
import QtQuick 2.0

GameWindow{
    id:gameWindow
    activeScene: gameScene
    screenWidth: 960
    screenHeight: 640
    EntityManager {
      id: entityManager
      entityContainer: gameScene
    }
    GameScene{
        id:gameScene

    }


}
