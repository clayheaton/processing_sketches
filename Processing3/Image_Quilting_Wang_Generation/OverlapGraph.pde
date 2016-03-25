class OverlapGraph {

  // The cut we'll want to make, stored as x,y coordinates in a PVector
  ArrayList<OverlapNode> seam;

  ArrayList<ArrayList> graph = new ArrayList<ArrayList>();
  OverlapNode start          = new OverlapNode();
  OverlapNode end            = new OverlapNode(true); // sets this as the goal

  int errorValue = 0;


  boolean left = false;
  boolean top  = false;

  int xMax, yMax;

  OverlapGraph() {
  }

  void initLeft(PImage _layerOne, PImage _layerTwo) {
    left = true;
    init(_layerOne, _layerTwo);
  }

  void initTop(PImage _layerOne, PImage _layerTwo) {
    top = true;
    init(_layerOne, _layerTwo);
  }

  void init(PImage _layerOne, PImage _layerTwo) {
    makeGraph(_layerOne, _layerTwo);

    Pathfinder pf = new Pathfinder();
    seam = pf.findSeam(start, end);

    // Figure out the cumulative error for this GRAPH, not just the seam
    for (ArrayList<OverlapNode> al : graph) {
      for (OverlapNode o : al) {
        errorValue += o.movementCost;
      }
    }
  }

  void makeGraph(PImage _layerOne, PImage _layerTwo) {
    _layerOne.loadPixels();
    _layerTwo.loadPixels();

    int w = _layerOne.width;
    int h = _layerOne.height;

    xMax = w - 1;
    yMax = h - 1;

    for (int i = 0; i < h; i++) {
      ArrayList<OverlapNode> r = new ArrayList<OverlapNode>();
      for (int j = 0; j < w; j++) {
        int pixelIndex = j + (i * w);
        color c1 = _layerOne.pixels[pixelIndex];
        color c2 = _layerTwo.pixels[pixelIndex];

        // For use in the A* heuristic
        int distToEnd = 0;
        if (left) {
          distToEnd = yMax - i;
        } else if (top) {
          distToEnd = xMax - j;
        }

        OverlapNode o = new OverlapNode(c1, c2, distToEnd);
        o.x = j;
        o.y = i;
        r.add(o);
      }
      graph.add(r);
    }

    connectNeighbors();
  }


  void connectNeighbors() {
    if (left) {
      leftConnect();
    } else if (top) {
      topConnect();
    }
  }

  // Determine the neighbors of a pixel (node) for a left overlap
  // Note that you could play with allowing more flexible movement
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

  // Determine the neighbors of a pixel (node) for a top overlap
  // Note that you could play with allowing more flexible movement
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

  // Convenience function for extracting a node from a graph.
  OverlapNode getNodeAt(int _x, int _y) {
    ArrayList<OverlapNode> a = graph.get(_y);
    OverlapNode o = a.get(_x);
    return o;
  }
}

