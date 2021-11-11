// Java program to print BFS traversal from a given source vertex.
// BFS(int s) traverses vertices reachable from s.
import java.io.*;
import java.util.*;

// This class represents a directed graph using adjacency list
// representation
class Graph 
{
  private int V; // No. of vertices
  private LinkedList<Integer> adj[]; //Adjacency Lists
  
  //Constructor
  Graph(int v) {
      V = v;
      adj = new LinkedList[v];
      for (int i = 0; i < v; ++i)
          adj[i] = new LinkedList();
  }
  
  //Function to add an edge into the graph
  void addEdge(int v, int w) {
      adj[v].add(w);
  }
  
  //printsBFS traversal from a given source s
  void BFT(int s) {
      // Mark all the vertices as not visited(By default
      // set as false)
      boolean visited[] = new boolean[V];
      
      // Create a queue for BFS
      LinkedList<Integer> queue = new LinkedList<Integer>();
      
      // Mark the current node as visited and enqueue it
      visited[s] = true;
      queue.add(s);
      
      while(queue.size() != 0)
          {
          // Dequeue a vertex from queue and print it
          s = queue.poll();
          print(s + " ");
          
          // Getalladjacent vertices of the dequeued vertex s
          // If a adjacent has not been visited, then mark it
          // visited and enqueue it
          Iterator<Integer> i = adj[s].listIterator();
          while(i.hasNext())
              {
              int n = i.next();
              if (!visited[n])
                  {
                  visited[n] = true;
                  queue.add(n);
              }
          }
      }
  }
  
  LinkedList<Integer> BFS(int start, int end) {
      HashMap<Integer, Integer> visited = new HashMap<>();
      LinkedList<Integer> queue = new LinkedList<Integer>();
      
      visited.put(start, null);
      int current = start;
      
      while(current != end) {
          LinkedList<Integer> adjacents = adj[current];
          for (int i : adjacents) {
              if (!visited.containsKey(i)) {
                  visited.put(i, current);
                  queue.add(i);
              }
          }
          current = queue.remove();
      }
      // print(visited);
      LinkedList<Integer> path = new LinkedList<>();
      path.addFirst(current);
      while(current != start) {
          current = visited.get(current);
          path.addFirst(current); // addFirst is used to get the correct order
          
      }
      
      //return path;
      return path;
  }
}

Graph g = new Graph(7);

g.addEdge(0, 1);
g.addEdge(0, 2);
g.addEdge(1, 3);
g.addEdge(2, 1);
g.addEdge(2, 4);
g.addEdge(3, 5);
g.addEdge(4, 6);
g.addEdge(5, 6);


print(g.adj); print("\n");

print(g.BFS(0, 6));print("\n");
