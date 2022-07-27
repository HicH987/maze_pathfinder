void initDisplay() {
  //generate randomly start coordinates
  startX = floor(random(0, cols - 1));
  startY = floor(random(0, rows - 1));
  startIndex = startY + startX * rows;
  //generate randomly destination coordinates
  endX = randomWithExclusion(0, cols - 1, startX);
  endY = randomWithExclusion(0, rows - 1, startY);
  endIndex = endY + endX * rows;
  nbObstacl = 100; //number of obstacles
  obstaclXY = new int[nbObstacl][2]; //for storing obstacles coordinates
  grid = new Cell[cols][rows];
  g = new Graph();
  pathMin = new LinkedList < Cell > ();
  createPath = false;
  vertices = new HashMap < > (); //for storing cells
  queue = new LinkedList < > ();
  visited = new HashMap < > (); //for storing visited cell : these parents

  createGrid();
  obstaclGenerator();
  //start
  grid[startX][startY].tine = colorStart;
  //end
  grid[endX][endY].tine = colorEnd;
  createGraph();
  //initialisations
  vertices = g.getVertices(); //get all grqph vertices
  startVert = vertices.get(startIndex); //get start cell
  endVert = vertices.get(endIndex); //get end cell
  visited.put(startVert, null); //initilise visited to start cell , and null for these parents
  current = startVert; //store current cell
}

int randomWithExclusion(int start, int end, int excludes) {
  int randomInt = floor(random(start, end));

  if (randomInt >= excludes)
    randomInt++;

  return randomInt;
}

void createGrid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int index = j + i * rows;
      grid[i][j] = new Cell(i * heightCell, j * widthCell, heightCell, widthCell, index);
    }
  }
}

//generate obstacles randomly
void obstaclGenerator() {
  for (int i = 0; i < nbObstacl; i++) {
    obstaclXY[i][0] = floor(random(0, cols - 1));
    obstaclXY[i][1] = floor(random(0, rows - 1));
  }
  for (int i = 0; i < nbObstacl; i++) {
    if (obstaclXY[i][0] != startX || obstaclXY[i][1] != startY) {
      if (obstaclXY[i][0] != endX || obstaclXY[i][1] != endY)
        grid[obstaclXY[i][0]][obstaclXY[i][1]].tine = colorObstacl;
    }
  }
}

void createGraph() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].tine != colorObstacl) {
        g.addCell(grid[i][j].index, grid[i][j]);

        if (j > 0 && grid[i][j - 1].tine != colorObstacl)
          grid[i][j].addAdjacent(grid[i][j - 1]);

        if (i > 0 && grid[i - 1][j].tine != colorObstacl)
          grid[i][j].addAdjacent(grid[i - 1][j]);

        if (j < rows - 1 && grid[i][j + 1].tine != colorObstacl)
          grid[i][j].addAdjacent(grid[i][j + 1]);

        if (i < cols - 1 && grid[i + 1][j].tine != colorObstacl)
          grid[i][j].addAdjacent(grid[i + 1][j]);
      }
    }
  }
}

void showGrid(Cell[][] grid) {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].display(40);
      if (grid[i][j].highlighted)
        grid[i][j].highlight(grid[i][j].tine);
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(radio)) {
    method = theEvent.value();
    println("checked", method);
  }

  if (theEvent.isFrom(btn_findPath)) {
    if (method > 0) {
      isPressed_findPath = true;
      println("got a button press", isPressed_findPath);
    }
  }

  if (theEvent.isFrom(btn_reset)) {
    isPressed_findPath = false;
    initDisplay();
    btn_reset.hide();
    println("Reset_button press");
  }
}

void setLock(Controller theController, boolean theValue) {
    if (theValue)
      theController.setColorBackground(color(100, 100));
    else
      theController.setColorBackground(color(#002d5a));



    theController.setMouseOver(false);

    theController.setLock(theValue); 

}












