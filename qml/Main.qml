import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.9
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
        onMenuScenePressed: {
            menuScene.playMenuMusic()
            gameWindow.state="menu"
            gameScene.visible=false
            menuScene.visible=true

        }

    }

    ChoosePlayer{
        id:chooseScene

        onGameScenePressed2: {
            gameScene.playGameMusic()
            gameWindow.state="game"
            menuScene.visible=false
            gameScene.visible=true

            chooseScene.visible=false
        }
        onGameScenePressed1: {
            menuScene.playMenuMusic()
            gameWindow.state="menu"
            gameScene.visible=false
            menuScene.visible=true

           chooseScene.visible=false
        }
    }

    MenuScene{
        id:menuScene
        onGameScenePressed: {
            gameScene.playGameMusic()
            gameWindow.state="game"
            menuScene.visible=false
            gameScene.visible=true
            chooseScene.visible=false

        }

        onGameScenePressed1:{
            gameWindow.state="choose"
            gameScene.visible=false
            menuScene.visible=false
            chooseScene.visible=true
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
        },
        State {
            name: "choose"
            PropertyChanges {
                target:gameWindow;opacity:1

            }
            PropertyChanges {
                target: gameWindow;activeScene:chooseScene

            }
        }

    ]


}
