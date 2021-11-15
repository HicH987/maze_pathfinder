int cols = 20;
int rows = 20;
int heightCell =  502 / rows;
int widthCell = 502 / cols;

int startX = 0;
int startY = 0;
int startIndex = startY + startX * rows;
int endX = cols - 1;
int endY = rows - 1;
int endIndex = endY + endX * rows;

int nbObstacl = 100;
int[][] obstaclXY = new int[nbObstacl][2];

Cell[][] grid = new Cell[cols][rows];
Graph g = new Graph();
LinkedList<Cell> pathMin = new LinkedList<Cell>();
// LinkedList<Cell> path = new LinkedList<Cell>();

boolean createPath= false;

color colorObstacl = color(179, 178, 178);
color colorStart = color(5, 255, 147); 
color colorEnd = color(255, 5, 147);
color colorPathMin = color(226, 219, 13); 
color colorPath = color(12, 87, 18); 

HashMap<Integer, Cell> vertices = new HashMap<>();
LinkedList<Cell> queue = new LinkedList<>(); 
Cell startVert;
Cell endVert;
Cell current;
HashMap<Cell, Cell> visited = new HashMap<>();

void setup() {
    size(502, 502);
    frameRate(60);
    
    createGrid();

    obstaclGenerator();

    //start
    grid[startX][startY].tine = colorStart;
    //end
    grid[endX][endY].tine = colorEnd;
    
    createGraph();
    
    //initialisations
    vertices = g.getVertices();

    startVert = vertices.get(startIndex);
    endVert = vertices.get(endIndex);
    
    visited.put(startVert, null); 
    current = startVert;
    
}


void draw() {

    background(0);

    showGrid(grid);
    //highlight obstacles cells
    for (int i = 0; i < nbObstacl; i++) {
        grid[obstaclXY[i][0]][obstaclXY[i][1]].highlight(colorObstacl);
        // grid[obstaclXY[i][0]][obstaclXY[i][1]].flower();
    }
    //highlight start and end cell
    grid[startX][startY].highlight(colorStart);
    grid[endX][endY].highlight(colorEnd);
    
    //start Breadth first search processing
    if (current!= endVert && createPath==false) {
        LinkedList<Cell> adjacents = current.getAdjacents();
        
        for (Cell v : adjacents) {
            if (!visited.containsKey(v)){ 
                visited.put(v, current);
                queue.add(v);
            }
        }
        
        if (queue.size()>0) {
            grid[current.x / heightCell][current.y / widthCell].highlight(colorPath);
            grid[current.x / heightCell][current.y / widthCell].tine = colorPath;
            current = queue.remove(); 
        }
       
        else{
            
            println("There is no path!!!!!!!!!!");
            println("press <Ctrl+c> to exit terminal");
            frameRate(0);
            // textSize(50);//text size
            // fill(0);//textcolor RGBalpha
            // text("There is no path", startX * heightCell + heightCell , startY * widthCell + widthCell);
        } 
    }

    //get optimal path
    if (current== endVert || createPath==true) {
        createPath=true;
        pathMin.addFirst(current);
       if(current != startVert) {
            current= visited.get(current);
            pathMin.addFirst(current);
        }
        else{
            if (pathMin.size() > 0) {
                Cell w = pathMin.getLast();
                if(w!=startVert){
                    grid[w.x / heightCell][w.y / heightCell].highlight(colorPathMin);
                    grid[w.x / heightCell][w.y / heightCell].tine = colorPathMin;
                }
                pathMin.removeLast();
            }
        }
    }

}





/////////////////////////////////////////////////////
//////////////////FUNCTIONS/////////////////////////
///////////////////////////////////////////////////

void createGrid(){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int index = j + i * rows;
            grid[i][j] = new Cell(i * heightCell, j * widthCell, heightCell, widthCell, index);
        }
    }
}

void obstaclGenerator() {
    for (int i = 0; i < nbObstacl; i++) {
        obstaclXY[i][0] = floor(random(0, cols - 1));
        obstaclXY[i][1] = floor(random(0, rows - 1));
    }
    for (int i = 0; i < nbObstacl; i++){
         if (obstaclXY[i][0] != startX || obstaclXY[i][1]!= startY) {
            if (obstaclXY[i][0] != endX || obstaclXY[i][1]!= endY)
                grid[obstaclXY[i][0]][obstaclXY[i][1]].tine = colorObstacl;
        }
    } 
}

void createGraph() {
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
}

void showGrid(Cell[][] grid) {
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            grid[i][j].display();
            if (grid[i][j].highlighted)
                grid[i][j].highlight(grid[i][j].tine);
        }
    }
}