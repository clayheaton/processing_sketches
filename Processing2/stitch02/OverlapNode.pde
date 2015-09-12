class OverlapNode {
  int x,y;
  
  boolean calculated = false;
  int r, g, b, r1, g1, b1;
  int cost;
  boolean goal = false;

  ArrayList<OverlapNode> neighbors = new ArrayList<OverlapNode>();

  // Only use this constructer when it is the start or end node
  OverlapNode(boolean start_or_end) {
    cost       = 0;
    calculated = true;
    goal       = true;
  }

  OverlapNode(int _r, int _g, int _b) {
    r = _r;
    g = _g;
    b = _b;
  }

  void addOverlap(int _r1, int _g1, int _b1) {
    r1 = _r1;
    g1 = _g1;
    b1 = _b1;

    cost = int(dist(r, g, b, r1, g1, b1));
  }

  void addNeighbor(OverlapNode o) {
    neighbors.add(o);
  }
  
}

