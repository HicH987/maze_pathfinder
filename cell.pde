class Cell {

  // A cell object knows about its location in the grid as well as its size with the variables x, y, w, h.
  int x, y;   // x,y location
  int w, h;   // width and height
  color tine;

  // Cell Constructor
  Cell(int tempX, int tempY, int tempW, int tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }

  // Oscillation means increase angle

  void display() {
    stroke(255);
    // Color calculated using sine wave
    fill(50);
    rect(x, y, w, h);
  }

  void highlight(color c) {
    tine = c;
    fill(c);
    rect(x, y, w, h);
  } 
}

