Cell[][] grid;

int cols = 6;
int rows = 6;
int heightCell = 302 / rows;
int widthCell = 302 / cols;

int startIndex = 0;
int endIndex = (cols - 1) + (rows - 1) * rows;

color colorObstacl = color(179, 178, 178);
color colorStat = color(8, 189, 23); 
color colorEnd = color(181, 25, 25);
color colorPath = color(226, 219, 13); 
// int startX = floor(random(0, 5));
// int startY = floor(random(0, 5));

// int endX = floor(random(0, 5));
// int endY = floor(random(0, 5));

int nbObstacl = 6;
int[][] obstaclXY = new int[nbObstacl][2];
void obstaclGenerator() {
    for (int i = 0; i < nbObstacl; i++) {
        obstaclXY[i][0] = floor(random(0, 5));
        if (obstaclXY[i][0] == 0)
            obstaclXY[i][1] = floor(random(1, 5));
        else 
            obstaclXY[i][1] = floor(random(0, 5));
        
        if (obstaclXY[i][0] == 5)
            obstaclXY[i][1] = floor(random(0, 4));
        else 
            obstaclXY[i][1] = floor(random(0, 5));
    }
    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].tine = colorObstacl;
    }
}



void setup() {
    size(302, 302);
    frameRate(3);
    grid = new Cell[cols][rows];
    Graph g = new Graph();
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int index = j + i * rows;
            grid[i][j] = new Cell(i * heightCell, j * widthCell, heightCell, widthCell, index);
        }
    }
    
    obstaclGenerator();
    //start
    grid[0][0].tine = colorStat;
    //end
    grid[5][5].tine = colorEnd;
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if (grid[i][j].tine !=  colorObstacl) {
                g.addCell(grid[i][j].index, grid[i][j]);
                
               if (j > 0 && grid[i][j - 1].tine !=  colorObstacl)
                    grid[i][j].addAdjacent(grid[i][j - 1]);
                
               if (i > 0 && grid[i - 1][j].tine !=  colorObstacl)
                    grid[i][j].addAdjacent(grid[i - 1][j]);
                
               if (j < rows - 1 && grid[i][j + 1].tine !=  colorObstacl)
                    grid[i][j].addAdjacent(grid[i][j + 1]);
                
               if (i < cols - 1 && grid[i + 1][j].tine !=  colorObstacl)
                    grid[i][j].addAdjacent(grid[i + 1][j]);
            }
    }
    }
    
    // for (int i=0; i< cols; i++) {
    //   for (int j=0; j<rows; j++) {
    
    //       grid[i][j].printCell(); print("      ");
    
    //   }
    //   print("\n");  
    
// }
    
    
    LinkedList<Cell> path = new LinkedList<>();
    path = g.breadthFirstSearch(0, 35);

    for (Cell c : path){
        if(c.index != 0  &&  c.index !=35)
         grid[(c.x)/heightCell][(c.y)/heightCell].tine=colorPath;
        //  showGrid(grid);
     }
    //  print(path.size(), "\n");
    // for (Cell c : path)
    //     print(c.index, " ");
}


void draw() {
    background(0);
    
    showGrid(grid);

    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].highlight(colorObstacl);
    }
    
    //start
    grid[0][0].highlight(colorStat);
    //end
    grid[5][5].highlight(colorEnd);

    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if(grid[i][j].tine == colorPath)
                grid[i][j].highlight(colorPath);

        }
    }

}




void showGrid(Cell[][] grid) {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            grid[i][j].display();
        }
    }
    
}