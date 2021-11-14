import java.io.*;
import java.util.*;
color col = color (47, 123, 3);
class Graph {
    
  private HashMap<Integer, Cell> vertices;

  public Graph() {
    this.vertices = new HashMap<>();
  }

  public void addCell(int index, Cell c) {
    vertices.put(index, c);
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
        if(queue.size()>0){
          // current.highlight(col);
          current = queue.remove(); // goes to the next Cell
        }
        else return null;
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
