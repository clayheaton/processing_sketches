public class OverlapNode implements Comparable<OverlapNode> {

  public int compareTo(OverlapNode node) {
    return this.priority - node.priority;
  }

  int x, y;
  int distToEnd;
  int movementCost;
  int cost;
  int priority;

  boolean isGoal  = false;
  boolean isStart = false;
  boolean onPath  = false;

  OverlapNode cameFrom;
  int costSoFar = -1;

  ArrayList<OverlapNode> neighbors = new ArrayList<OverlapNode>();

  // Initialize the start and the target
  OverlapNode() {
    isStart = true;
    movementCost = 0;
  }

  OverlapNode(boolean _isGoal) {
    isGoal = _isGoal;
    movementCost = 0;
  }

  OverlapNode(color _first, color _second, int _distToEnd) {
    int r = (_first >> 16) & 0xFF;   // Faster way of getting red(_first)
    int g = (_first >> 8)  & 0xFF;   // Faster way of getting green(_first)
    int b = _first & 0xFF;           // Faster way of getting blue(_first)

    int r2 = (_second >> 16) & 0xFF;
    int g2 = (_second >> 8)  & 0xFF; 
    int b2 = _second & 0xFF;        

    distToEnd = _distToEnd;

    movementCost  = int(sq(r - r2) + sq(g - g2) + sq(b - b2));
  }

  void addNeighbor(OverlapNode n) {
    neighbors.add(n);
  }

  public String toString() {
    return "x: " + x + ", y: " + y;
  }
}

