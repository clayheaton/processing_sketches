class OverlapGraph {
  OverlapNode start;
  OverlapNode end;

  int xMax, yMax;

  ArrayList<ArrayList> graph;

  OverlapGraph() {
    graph = new ArrayList<ArrayList>();

    start = new OverlapNode(true);
    end   = new OverlapNode(true);
  }

  void add(ArrayList<OverlapNode> a) {
    graph.add(a);
  }

  // Each node connects to three others
  // As long as they fall within bounds of allowed x and y
  //          x
  //      lo mo ro
  void leftConnect() {
    // Establish link from start to first line
    ArrayList<OverlapNode> topLine = graph.get(0);
    for (OverlapNode o : topLine) {
      start.addNeighbor(o);
    }

    // Now connect the rest
    for (ArrayList<OverlapNode> a : graph) {
      for (OverlapNode o : a) {

        int nextY = o.y + 1;
        if (nextY > yMax) {
          // We're on the last row, so connect to the graph end
          o.addNeighbor(end);
          continue;
        }

        // Get the left one
        int leftX = o.x - 1;
        if (leftX >= 0) {
          OverlapNode lo = getNodeAt(leftX, nextY);
          o.addNeighbor(lo);
        }

        // Get the middle one
        int middleX = o.x;
        OverlapNode mo = getNodeAt(middleX, nextY);
        o.addNeighbor(mo);

        // Get the right one
        int rightX = o.x + 1;
        if (rightX <= xMax) {
          OverlapNode ro = getNodeAt(rightX, nextY);
          o.addNeighbor(ro);
        }
      }
    }
  }

  // Each node connects to three others, as long as they 
  // are in bounds.
  //              ao
  //            x mo
  //              bo
  void topConnect() {
    // Establish the link from start to first line
    for (ArrayList<OverlapNode> a : graph) {
      OverlapNode o = a.get(0);
      start.addNeighbor(o);
    }

    for (ArrayList<OverlapNode> a : graph) {
      for (OverlapNode o : a) {

        int nextX = o.x + 1;
        if (nextX > xMax) {
          // Attach to the end node and break
          o.addNeighbor(end);
          continue;
        }

        // Get the one at a lower Y position
        int aboveY = o.y - 1;
        if (aboveY >= 0) {
          OverlapNode ao = getNodeAt(nextX, aboveY);
          o.addNeighbor(ao);
        }

        // Get the one at the same Y position
        int middleY = o.y;
        OverlapNode mo = getNodeAt(nextX, middleY);
        o.addNeighbor(mo);

        // Get the one at the greater Y postiion
        int belowY = o.y + 1;
        if (belowY <= yMax) {
          OverlapNode bo = getNodeAt(nextX, belowY);
          o.addNeighbor(bo);
        }
      }
    }
  }

  OverlapNode getNodeAt(int _x, int _y) {
    ArrayList<OverlapNode> a = graph.get(_y);
    OverlapNode o = a.get(_x);
    return o;
  }
}

