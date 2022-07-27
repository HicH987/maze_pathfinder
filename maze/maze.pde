import controlP5.*;

int cols = 20; //for x
int rows = 20; //for y
int heightCell = 502 / cols; //for x
int widthCell = 502 / rows; //for y

//generate randomly start coordinates
int startX = floor(random(0, cols - 1));
int startY = floor(random(0, rows - 1));
int startIndex = startY + startX * rows;

//generate randomly destination coordinates
int endX = randomWithExclusion(0, cols - 1, startX);
int endY = randomWithExclusion(0, rows - 1, startY);
int endIndex = endY + endX * rows;

int nbObstacl = 100; //number of obstacles
int[][] obstaclXY = new int[nbObstacl][2]; //for storing obstacles coordinates

Cell[][] grid = new Cell[cols][rows];
Graph g = new Graph();
LinkedList < Cell > pathMin = new LinkedList < Cell > ();
boolean createPath = false;

color colorFreeCell = 50;
color colorObstacl = color(179, 178, 178);
color colorStart = color(5, 255, 147);
color colorEnd = color(255, 5, 147);
color colorPathMin = color(226, 219, 13);
color colorPath = color(12, 87, 18);

HashMap < Integer, Cell > vertices = new HashMap < > (); //for storing cells
HashMap < Cell, Cell > visited = new HashMap < > (); //for storing visited cell : these parents
LinkedList < Cell > queue = new LinkedList < > ();
Cell startVert;
Cell endVert;
Cell current;

ControlP5 controlP5;
RadioButton radio;
Button btn_findPath, btn_reset;

Boolean isPressed_findPath = false;
float method = 0;

void setup() {
  size(700, 502);
  frameRate(60);

  controlP5 = new ControlP5(this);
  radio = controlP5.addRadioButton("radioButton")
    .setPosition(525, 20)
    .setSize(50, 50)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSpacingRow(50)
    .addItem("BFS", 1)
    .addItem("DFS", 2);

  btn_findPath = controlP5.addButton("Find Path")
    .setPosition(525, 200)
    .setSize(150, 50);
  btn_reset = controlP5.addButton("Reset")
    .setPosition(550, 400)
    .setSize(100, 30)
    .setVisible(false);

  initDisplay();
}

void draw() {
  background(0);
  showGrid(grid);

  //highlight obstacles cells
  for (int i = 0; i < nbObstacl; i++)
    grid[obstaclXY[i][0]][obstaclXY[i][1]].highlight(colorObstacl);

  //highlight start and end cell
  grid[startX][startY].highlight(colorStart);
  grid[endX][endY].highlight(colorEnd);

  if (isPressed_findPath == true && method > 0) {
    //start Breadth first search processing
    if (current != endVert && createPath == false) {
      LinkedList < Cell > adjacents = current.getAdjacents();

      for (Cell v: adjacents) {
        if (!visited.containsKey(v)) {
          visited.put(v, current);
          // if bfs method selected
          if (method == 1.0)
            queue.addLast(v);
          // if dfs method selected
          else if (method == 2.0)
            queue.addFirst(v);
        }
      }
      if (queue.size() > 0) {
        grid[current.x / heightCell][current.y / widthCell].highlight(colorPath);
        grid[current.x / heightCell][current.y / widthCell].tine = colorPath;
        current = queue.removeFirst();
      } else {
        btn_reset.show();
        println("There is no path!!!!!!!!!!");
        println("press: \n= <Ctrl+c> to exit terminal \nor \n= <Reset> button");
        frameRate(0);
      }
    }
    //get optimal path
    if (current == endVert || createPath == true) {
      createPath = true;
      pathMin.addFirst(current);
      if (current != startVert) {
        current = visited.get(current);
        pathMin.addFirst(current);
      } else {
        if (pathMin.size() > 0) {
          Cell w = pathMin.getLast();
          if (w != startVert) {
            grid[w.x / heightCell][w.y / widthCell].highlight(colorPathMin);
            grid[w.x / heightCell][w.y / widthCell].tine = colorPathMin;
          } else
            btn_reset.show();

          pathMin.removeLast();
        }
      }
    }
  }
}