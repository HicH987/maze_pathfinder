// color [] RGB = {#ff0000,#00ff00,#0000ff}; 
// color c = RGB[floor(random(0,2))];

class Cell {

  LinkedList<Cell> adjacents;
  int x, y;   // x,y location
  int w, h;   // width and height
  int index;
  color tine;
  Boolean highlighted = false;

  Cell(int tempX, int tempY, int tempW, int tempH, int i) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    index = i;

    this.adjacents = new LinkedList<>();
  }

  int getX(){
    return this.x/h;
  }
  int getY(){
    return this.x/w;
  }

  void addAdjacent(Cell adjacentCell) {
    adjacents.add(adjacentCell);
  }

  LinkedList<Cell> getAdjacents() {
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

  void flower(){
    strokeWeight(0.5);
    stroke(0);
    highlighted= true;

    // fill(c);
    ellipse(x+w/4, y+h/4, w/2, h/2);
    ellipse((x+w/4)+ w/2, y+h/4, w/2, h/2);
    ellipse(x+w/4, (y+h/4)+ h/2, w/2, h/2);
    ellipse((x+w/4)+ w/2,(y+h/4)+ h/2, w/2, h/2);
    ///
    ellipse(x+w/2, y+h/2, w/2, h/2);
    
  }
}

