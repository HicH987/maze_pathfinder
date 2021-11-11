// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 6;
int rows = 6;


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
}


void setup() {
    size(302, 302);

    grid = new Cell[cols][rows];
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            // Initialize each object
            grid[i][j] = new Cell(i * 50, j * 50, 50, 50);
        }
    }
    
    obstaclGenerator();
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
