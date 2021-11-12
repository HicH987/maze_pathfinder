// Java program to print BFS traversal from a given source vertex.
// BFS(int s) traverses vertices reachable from s.
import java.io.*;
import java.util.*;

// This class represents a directed graph using adjacency list
// representation
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

// Graph g = new Graph(7);

// g.addEdge(0, 1);
// g.addEdge(0, 2);
// g.addEdge(1, 3);
// g.addEdge(2, 1);
// g.addEdge(2, 4);
// g.addEdge(3, 5);
// g.addEdge(4, 6);
// g.addEdge(5, 6);


// print(g.adj); print("\n");

// print(g.BFS(0, 6));print("\n");
