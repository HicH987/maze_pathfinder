class Cell {

  private LinkedList<Cell> adjacents;
  int x, y;   // x,y location
  int w, h;   // width and height
  int index;
  color tine;
  Boolean highlighted = false;

  public Cell(int tempX, int tempY, int tempW, int tempH, int i) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    index = i;
    this.adjacents = new LinkedList<>();
  }

  public void addAdjacent(Cell adjacentCell) {
    adjacents.add(adjacentCell);
  }

  public LinkedList<Cell> getAdjacents() {
    return this.adjacents;
  }

  void display() {
    stroke(255);
    fill(50);
    rect(x, y, w, h);
  }

  void highlight(color c) {
    highlighted= true;
    stroke(255);
    fill(c);
    rect(x, y, w, h);
  } 
}

