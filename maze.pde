Cell[][] grid;

int cols = 6;
int rows = 6;
int heightCell = 50;
int widthCell = 50;

color colorObstacl = color (179, 178, 178);
color colorStat = color (8, 189, 23); 
color colorEnd = color (181, 25, 25) ; 
// int startX = floor(random(0, 5));
// int startY = floor(random(0, 5));

// int endX = floor(random(0, 5));
// int endY = floor(random(0, 5));

int nbObstacl = 5;
int[][] obstaclXY = new int[5][2];

void obstaclGenerator() {
    for (int i = 0; i < nbObstacl; i++) {
        for (int j = 0; j < 2; j++) {
            obstaclXY[i][j] = floor(random(0, 5));
        }
    }
    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].tine=colorObstacl;
    }
}


void setup() {
    size(302, 302);

    grid = new Cell[cols][rows];
    Graph g = new Graph();

    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int index = j+i*rows;
            grid[i][j] = new Cell(i * heightCell, j * widthCell, heightCell, widthCell, index);
        }
    }

    obstaclGenerator();
    //start
    grid[0][0].tine=colorStat;
    //end
    grid[5][5].tine=colorEnd;

}


void draw() {
    background(0);
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            grid[i][j].display();
        }
    }
    
    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].highlight(colorObstacl);
    }
    
    //start
    grid[0][0].highlight(colorStat);
    //end
    grid[5][5].highlight(colorEnd);
    
}
