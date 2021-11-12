import java.io.*;
import java.util.*;

class Cell {
  private LinkedList<Cell> adjacents;
  int x, y;   // x,y location
  int w, h;   // width and height
  int index;
  color tine;
  boolean obstacl;

  public Cell(int tempX, int tempY, int tempW, int tempH, int i, boolean b) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    index = i;
    obstacl = b;

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
}

class Graph {
  private HashMap<Integer, Cell> vertices;

  public Graph() {
    this.vertices = new HashMap<>();
  }

  public void addCell(int index, Cell c) {
    vertices.put(index, c);
  }

  public void addEdge(int c1, int c2) {
    Cell v1 = vertices.get(c1);
    Cell v2 = vertices.get(c2);

    v1.addAdjacent(v2);
    v2.addAdjacent(v1);
  }

  public LinkedList<Cell> breadthFirstSearch(int start, int end) {
    Cell startVert = vertices.get(start);
    Cell endVert = vertices.get(end);

    LinkedList<Cell> queue = new LinkedList<>(); // LinkedList implements Queue
    HashMap<Cell, Cell> visited = new HashMap<>();

    visited.put(startVert, null); // this is the first Cell

    Cell current = startVert; // the current Cell to check
    while (current != endVert) { // repeats until the end is reached

      LinkedList<Cell> adjacents = current.getAdjacents(); // get adjacents

      for (Cell v : adjacents) { // add all the adjacents
        if (!visited.containsKey(v)) { // but only if it hasn't already been traversed
          visited.put(v, current);
          queue.add(v);
        }
      }

      current = queue.remove(); // goes to the next Cell
    }

    // create the path
    LinkedList<Cell> path = new LinkedList<>();
    path.addFirst(current);
    while (current != startVert) {
      current = visited.get(current);
      path.addFirst(current); // addFirst is used to get the correct order
    }

    return path;
  }
}
Cell[][] grid = new Cell[3][3];
Graph g = new Graph();

for (int i=0; i<3; i++) {
  for (int j=0; j<3; j++) {
    int index = j+i*3;
    if (index == 5)
      grid[i][j] = new Cell(i, j, 1, 1, index, true);
    else
      grid[i][j] = new Cell(i, j, 1, 1, index, false);
  }
}


for (int i=0; i<3; i++) {
  for (int j=0; j<3; j++) {
    if (!grid[i][j].obstacl) {
      g.addCell(grid[i][j].index, grid[i][j]);
      if (j>0 && !grid[i][j-1].obstacl)
        grid[i][j].addAdjacent(grid[i][j-1]);

      if (i>0 && !grid[i-1][j].obstacl)
        grid[i][j].addAdjacent(grid[i-1][j]);

      if (j<2 && !grid[i][j+1].obstacl)
        grid[i][j].addAdjacent(grid[i][j+1]);

      if (i<2 && !grid[i+1][j].obstacl)
        grid[i][j].addAdjacent(grid[i+1][j]);
    }
  }
}

LinkedList<Cell> path = new LinkedList<>();
path = g.breadthFirstSearch(0, 8);

for (Cell c : path)
  print(c.index, " ");
