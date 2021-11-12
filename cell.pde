class Cell {
  private LinkedList<Cell> adjacents;
  int x, y;   // x,y location
  int w, h;   // width and height
  int index;
  color tine;
  // boolean obstacl;

  public Cell(int tempX, int tempY, int tempW, int tempH, int i /*, boolean b*/) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    index = i;
    // obstacl = b;

    this.adjacents = new LinkedList<>();
  }

  void printCell() {
    print(x, " : ", y, " /", index);
  }

  public void addAdjacent(Cell adjacentCell) {
    adjacents.add(adjacentCell);
  }

  public LinkedList<Cell> getAdjacents() {
    return this.adjacents;
  }

  // Oscillation means increase angle

  void display() {
    stroke(255);
    // Color calculated using sine wave
    fill(50);
    rect(x, y, w, h);
  }

  void highlight(color c) {
    // tine = c;
    fill(c);
    rect(x, y, w, h);
  } 
}

