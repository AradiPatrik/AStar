
int rows = 100;
int cols = 100;

boolean isPlaying;

Node[][] grid = new Node[rows][cols];
ArrayList<Node> openSet = new ArrayList<Node>();
ArrayList<Node> closedSet = new ArrayList<Node>();

Node start;
Node goal;

public void setup(){

  for(int i = 0; i < rows; ++i){
    for(int j = 0; j < cols; ++j){
      grid[i][j] = new Node(i, j);
    }
  }
  
  for(int i = 0; i < rows; ++i){
    for(int j = 0; j < cols; ++j){
      grid[i][j].setUpNeighbors();
    }
  }
  
  start = grid[0][0];
  goal = grid[rows-1][cols-1];
  start.isObstacle = goal.isObstacle = false;
  
  openSet.add(start);
  
  size(800,800);
  //fullScreen();

}

public void draw(){
  
  // display grid
  for(int i = 0; i < rows; ++i){
    for(int j = 0; j < cols; ++j){
      grid[i][j].show(Color.WHITE.toVector());
    }
  }
  
  // display open set
  for(Node node : openSet){
    node.show(Color.GREEN.toVector());
  }
  
  // display closed set
  for(Node node : closedSet){
    node.show(Color.RED.toVector());
  }
  if(isPlaying)
    aStar();
  
}

void aStar(){
  
  if(openSet.isEmpty()){
    System.out.println("path does not exist");
    stop();
  }
  
  // get best fit from set
  Node candidate = openSet.get(0);
  for(Node node : openSet){
    if(candidate.total > node.total){
      candidate = node;
    }
  }
  
  if(candidate.x == goal.x && candidate.y == goal.y){
    System.out.println("found it");
    stop();
  }
  
  
  
  // remove best fit from open set, and add it to the closed set
  openSet.remove(candidate);
  closedSet.add(candidate);
  
  // calculate neighbors g, if it is higher than the original, than change it
  // than add it to the openSet, if it wasn't already in it
  for(Node node : candidate.neighbors){
    if(!closedSet.contains(node) && !node.isObstacle){
      double dist = candidate.until + 1;
      if(openSet.contains(node)){
        if(node.until > dist){
          node.until = dist;
          node.previous = candidate;
        }
      }else{
        node.until = dist;
        openSet.add(node);
        node.previous = candidate;
      }
    }
    
    node.rem = dist(node.x, node.y, goal.x, goal.y);
    node.total = node.rem + node.until;
    
  }
  
  display(candidate);

}

void display(Node candidate){
  // display current best path
  
  ArrayList<Node> path = new ArrayList<Node>();
  Node temp = candidate;
  while(temp.previous != null){
    path.add(temp);
    temp = temp.previous;
  }
  for(Node node : path){
    node.show(Color.BLUE.toVector());
  }
}

void mouseDragged(){
  Node closest = grid[0][0];
  ArrayList<Node> nodes = new ArrayList<Node>();
  for(int i = 0; i < rows; ++i){
    for(int j = 0; j < cols; ++j){
      nodes.add(grid[i][j]);
    }
  }
  for(Node node : nodes){
    float x = node.x * node.w;
    float y = node.y * node.h;
    float cx = closest.x * closest.w;
    float cy = closest.y * closest.h;
    float dst = abs(x- mouseX) + abs(y-mouseY);
    float cdst = abs(cx - mouseX) + abs(cy-mouseY);
    if(dst < cdst){
      closest = node;
    }
  }
  closest.isObstacle = true;
  for(Node node : closest.neighbors){
    node.isObstacle = true;
  }
}

void keyPressed(){
  isPlaying = !isPlaying;
}