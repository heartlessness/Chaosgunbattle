import QtQuick 2.0
import Felgo 3.0
 Item{
     id:level
     height: gameScene.gridSize * 10 // 32 * 10 = 320
     Platform{
         row:1
         column: 5
         size:4
     }
     Platform{
         row:3
         column: 7
         size:3
     }
     Platform{
         row:11
         column: 8
         size:3
     }
      Platform{
          row:1
          column:3
          size:3
      }
     Platform{
         row:5
         column: 4
         size:4
     }
     Platform{
         row:10
         column: 3
         size:4
     }
     Platform{
         row:9
         column: 1
         size: 4
     }
     Platform{
         row:11
         column: 5
         size:2
     }

     Platform {
       row: 7
       column: 6
       size: 4
     }

     function platformPoint(a){
         var list = level.children

         return mapToItem(level,list[a].x,list[a].y)
     }

}
