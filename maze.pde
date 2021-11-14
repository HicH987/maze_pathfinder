int cols = 20;
int rows = 20;
int heightCell =  502/ rows;
int widthCell = 502/ cols;

int startX = 0;
int startY = 0;
int startIndex = startY + startX * rows;
int endX = cols-1;
int endY = rows-1 ;
int endIndex = endY + endX * rows;

int nbObstacl =100;
int[][] obstaclXY = new int[nbObstacl][2];

Cell[][] grid = new Cell[cols][rows];
Graph g = new Graph();
LinkedList<Cell> pathMin = new LinkedList<Cell>();
// LinkedList<Cell> path = new LinkedList<Cell>();

boolean blocked = false;
color colorObstacl = color(179, 178, 178);
color colorStat = color(8, 189, 23); 
color colorEnd = color(181, 25, 25);
color colorPathMin = color(226, 219, 13); 
color colorPath = color(85, 235, 97); 

//int startX = floor(random(0, 5)); int startY = floor(random(0, 5)); int endX = floor(random(0, 5)); int endY = floor(random(0, 5));

void setup() {
    size(502, 502);
    frameRate(3);

    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int index = j + i * rows;
            grid[i][j] = new Cell(i * heightCell, j * widthCell, heightCell, widthCell, index);
        }
    }
    
    obstaclGenerator();
    //start
    grid[startX][startY].tine = colorStat;
    //end
    grid[endX][endY].tine = colorEnd;
    
    createGraph();
    
    pathMin = g.breadthFirstSearch(startIndex, endIndex);
    if (pathMin != null)
        for (Cell c :  pathMin) {
            if (c.index != startIndex &&  c.index != endIndex)
                grid[(c.x) / heightCell][(c.y) / widthCell].tine = colorPathMin;
                grid[(c.x) / heightCell][(c.y) / widthCell].visited = true;
        }
    else
       blocked = true;  
}


void draw() {
    background(0);

    showGrid(grid);
    

    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].highlight(colorObstacl);
        // grid[obstaclXY[i][0]][obstaclXY[i][1]].flower();
        
    }
    //start
    grid[startX][startY].highlight(colorStat);
    //end
    grid[endX][endY].highlight(colorEnd);
    
    if(!blocked){
        if (pathMin.size() > 0) {
            Cell current = pathMin.getFirst();
            grid[current.x / heightCell][current.y / heightCell].highlight(colorStat);
            pathMin.removeFirst();
        }
    }

    else{

        textSize(50);//text size
        fill(0);//textcolor RGBalpha

        text("No path", startX * heightCell + heightCell , startY * widthCell + widthCell);

    }

}


void showGrid(Cell[][] grid) {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            grid[i][j].display();
        }
    }
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if (grid[i][j].highlighted)
                grid[i][j].highlight(grid[i][j].tine);
        }
    }
}

void obstaclGenerator() {
    for (int i = 0; i < nbObstacl; i++) {
        obstaclXY[i][0] = floor(random(0, cols-1));
        obstaclXY[i][1] = floor(random(0, rows-1));
        // if (obstaclXY[i][0] == 0)
        //     obstaclXY[i][1] = floor(random(startY+1, endY));
        // else 
        //     obstaclXY[i][1] = floor(random(startY, endY));
        // if (obstaclXY[i][0] == endX)
        //     obstaclXY[i][1] = floor(random(startY, endY-1));
        // else 
        //     obstaclXY[i][1] = floor(random(startY, endY));
    }
    for (int i = 0; i < nbObstacl; i++)
    {
        if(obstaclXY[i][0] != startX || obstaclXY[i][1]!=startY){
            if(obstaclXY[i][0] != endX || obstaclXY[i][1]!=endY)
                grid[obstaclXY[i][0]][obstaclXY[i][1]].tine = colorObstacl;
        }
    } 
}

void createGraph (){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            if (grid[i][j].tine !=  colorObstacl && !grid[i][j].visited) {
                g.addCell(grid[i][j].index, grid[i][j]);
                
                if (j > 0 && grid[i][j - 1].tine !=  colorObstacl && !grid[i][j - 1].visited )
                    grid[i][j].addAdjacent(grid[i][j - 1]);
                
                if (i > 0 && grid[i - 1][j].tine !=  colorObstacl && !grid[i - 1][j].visited)
                    grid[i][j].addAdjacent(grid[i - 1][j]);
                
                if (j < rows - 1 && grid[i][j + 1].tine !=  colorObstacl && !grid[i][j + 1].visited)
                    grid[i][j].addAdjacent(grid[i][j + 1]);
                
                if (i < cols - 1 && grid[i + 1][j].tine !=  colorObstacl && !grid[i + 1][j].visited)
                    grid[i][j].addAdjacent(grid[i + 1][j]);
            }
        }
    }
}