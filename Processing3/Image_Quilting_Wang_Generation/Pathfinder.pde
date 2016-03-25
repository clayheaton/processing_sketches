class Pathfinder {

  ArrayList<OverlapNode> seam;

  Pathfinder() {
    seam = new ArrayList<OverlapNode>();
  }

  ArrayList<OverlapNode> findSeam(OverlapNode _start, OverlapNode _end) {
    aStar(_start, _end);
    return seam;
  }

  // See the implementation and explanation here:
  // http://www.redblobgames.com/pathfinding/a-star/introduction.html
  void aStar(OverlapNode _start, OverlapNode _end) {
    PriorityQueue<OverlapNode> frontier = new PriorityQueue<OverlapNode>(sampleSize * sampleOverlap);

    OverlapNode goal = new OverlapNode();

    // Set the priority of the start to zero and 
    // add it to the frontier
    _start.priority = 0;
    frontier.offer(_start);

    while (!frontier.isEmpty ()) {
      OverlapNode current = frontier.poll();

      if (current.isGoal) {
        goal = current;
        break;
      }

      for (OverlapNode next : current.neighbors) {
        int new_cost = current.costSoFar + next.movementCost;

        if (next.costSoFar == -1 || new_cost < next.costSoFar) {
          next.costSoFar = new_cost;
          next.priority = new_cost + next.distToEnd; // lame heuristic, but accurate
          frontier.offer(next);
          next.cameFrom = current;
        }
      }
    }

    // Store the path that we found as the "seam" (between the sample and what's already on the canvas)
    // We don't need to add the goal because it's not part of the path of interest. Neither is the start.
    while (goal.isStart == false) {
      if (goal.isStart || goal.isGoal) {
        goal = goal.cameFrom;
        continue;
      }
      goal.onPath = true;
      seam.add(goal);
      goal = goal.cameFrom;
    }
  }
}

