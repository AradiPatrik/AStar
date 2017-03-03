public class Node{

  int x;
  int y;
  int w;
  int h;
  
  double total;
  double until;
  double rem;
  
  boolean isObstacle = false;
  
  Node previous;
  ArrayList<Node> neighbors;
  
  public Node(int x, int y){
    
    this.x = x;
    this.y = y;
    w = width/rows;
    h = height/cols;
    
    total = rem = until = 0;
    // isObstacle = random(1) < 0.4;
  }
  
  public void show(PVector col){
    stroke(0);
    fill(col.x, col.y, col.z);
    if(isObstacle){
      fill(0);
    }
    rect( x*w, y*h, w-1, h-1 );
  }
  
  public void setUpNeighbors(){
    neighbors = new ArrayList<Node>();
    if(x > 0)
      neighbors.add(grid[x-1][y]);
    if(y > 0)
      neighbors.add(grid[x][y-1]);
    if(x < cols - 1)
      neighbors.add(grid[x+1][y]);
    if(y < rows - 1)
      neighbors.add(grid[x][y+1]);
    if(x > 0 && y > 0)
      neighbors.add(grid[x-1][y-1]);
    if(x < cols-1 && y > 0)
      neighbors.add(grid[x+1][y-1]);
    if(x > 0 && y < rows-1)
      neighbors.add(grid[x-1][y+1]);
    if(x < cols - 1 && y < rows-1)
      neighbors.add(grid[x+1][y+1]);
  }

  @Override
  public String toString(){
    return x + " " + y;
  }
}