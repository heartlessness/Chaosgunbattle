import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9
GameWindow{
    id:gameWindow
    activeScene: gameScene
    screenWidth: 960
    screenHeight: 640

//    MediaPlayer {
//        id: playMusic
//        source: "../assets/bgmusic.mp3"
//        Audio:Audio{}

//    }
    EntityManager {
      id: entityManager
      entityContainer: gameScene
    }
    GameScene{
        id:gameScene
        onMenuScenePressed: {
            gameWindow.state="menu"
            gameScene.visible=false
            menuScene.visible=true
        }

    }
    MenuScene{
        id:menuScene
        onGameScenePressed: {
            gameWindow.state="game"
            menuScene.visible=false
            gameScene.visible=true
        }
    }

    state:"menu"
    states:[
        State{
            name:"menu"
            PropertyChanges {
                target: menuScene;opacity:1
            }
            PropertyChanges {
                target: gameWindow;activeScene:menuScene
            }
        },
        State{
            name:"game"
            PropertyChanges {
                target: gameScene;opacity:1
            }
            PropertyChanges {
                target: gameWindow;activeScene:gameScene
            }
        }

    ]


}
