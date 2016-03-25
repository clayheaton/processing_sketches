class Sample {
  PImage source, sample, overlappingLeft, overlappingTop;
  OverlapGraph leftGraph, topGraph;
  int thisSampleSize, thisXOffset, thisYOffset;

  // These help handle right edge and bottom edge tiles that look 
  // for matches in the black offscreen space of the canvas
  float percentWOnScreen = 1.0;
  float percentHOnScreen = 1.0;

  // Constructor for initial image quilting
  Sample(PImage _source) {
    thisSampleSize = sampleSize;
    source = _source;
    thisXOffset = xOffset;
    thisYOffset = yOffset;
    createSample();
  }

  // WangTileMaker constructor
  Sample(PImage _source, int _size) {
    thisSampleSize = _size;
    source = _source;
  }

  // Overridden for Wang tiles...
  void createSample(int _xOffset, int _yOffset) {
    thisXOffset = _xOffset;
    thisYOffset = _yOffset;
    createSample();
  }


  // For use with the initial image quilting
  void createSample() {
    //println("Sample.createSample()");
    int sample_x_start = int(random(0, source.width  - thisSampleSize));
    int sample_y_start = int(random(0, source.height - thisSampleSize));
    sample = source.get(sample_x_start, sample_y_start, thisSampleSize, thisSampleSize);

    // Used to help determine what percentage of the error we check for overlapping sections.
    int pixelsRemainingW = width - thisXOffset;
    int pixelsRemainingH = height - thisYOffset;

    // Find the percentage with bounds at 0 and 1.0.
    percentWOnScreen = max(0, min(1.0, pixelsRemainingW - thisSampleSize));
    percentHOnScreen = max(0, min(1.0, pixelsRemainingH - thisSampleSize));
  }


  void placeTile(int _xOffset, int _yOffset) {

    boolean success = calculateOverlapCuts();
    while (!success) {
      // println("Failed to succeed at calculateOverlapCuts()");
      createSample();
      success = calculateOverlapCuts();
    }

    OverlapNode cornerCross = new OverlapNode();
    boolean useCornerCross = false;

    if (null != leftGraph && null != topGraph) {
      cornerCross = cornerCross();
      useCornerCross = true;
    }


    if (null != leftGraph) {
      for (OverlapNode o : leftGraph.seam) {
        int x = o.x;
        int y = o.y;
        // Assign the pixel from THE CANVAS to sample if it is left of the seam
        if (debug) {
          int debugx = _xOffset + x;
          int debugy = _yOffset + y;
          if (useCornerCross == false) {
            debugLines.add(new PVector(debugx, debugy));
          } else if (debugy >= cornerCross.y) {
            debugLines.add(new PVector(debugx, debugy));
          }
        }
        for (int i = 0; i < x; i++) {
          sample.set(i, y, get(_xOffset + i, _yOffset + y));
        }
      }
    }

    if (null != topGraph) {
      for (OverlapNode o : topGraph.seam) {
        int x = o.x;
        int y = o.y;
        // Assign the pixel from THE CANVAS to sample if it is above the seam
        if (debug) {
          int debugx = _xOffset + x;
          int debugy = _yOffset + y;
          if (useCornerCross == false) {
            debugLines.add(new PVector(debugx, debugy));
          } else if (debugx >= cornerCross.x) {
            debugLines.add(new PVector(debugx, debugy));
          }
        }
        for (int i = 0; i < y; i++) {
          sample.set(x, i, get(_xOffset + x, _yOffset + i)); // BUG?
        }
      }
    }
    sample.updatePixels();

    image(sample, _xOffset, _yOffset);
  }


  boolean calculateOverlapCuts() {
    // Need to calculate the total error possible for all overlap pixels
    // the determine whether the error represented in 
    //println("Sample.calculateOverlapCuts()");

    int adjustedError, adjustedMaxError;    

    if (row == 0 && column > 0) {
      createOverlappingLeft();
      createLeftGraph();
      
      // Make sure the top graph is null so that it isn't processed;
      // Not explicitly setting this to null caused a gnarly bug.
      topGraph = null;

      adjustedError    = int(percentHOnScreen * leftGraph.errorValue);
      adjustedMaxError = int(percentHOnScreen * maxErrorValue);

      if (adjustedError > adjustedMaxError) {
        return false;
      }
      return true;
    }

    if (row > 0 && column == 0) {
      createOverlappingTop();
      createTopGraph();
      
      // Make sure the left graph is null so that it isn't processed.
      leftGraph = null;

      adjustedError    = int(percentWOnScreen * topGraph.errorValue);
      adjustedMaxError = int(percentWOnScreen * maxErrorValue);

      if (adjustedError > adjustedMaxError) {
        // println("topGraph adjustedError: " + adjustedError);
        return false;
      }
      return true;
    }

    if (row > 0 && column > 0) {
      createOverlappingLeft();
      createLeftGraph();

      createOverlappingTop();
      createTopGraph();

      int adjustedLeftError    = int(percentHOnScreen * leftGraph.errorValue);
      int adjustedLeftMaxError = int(percentHOnScreen * maxErrorValue); // Problem here?

      int adjustedTopError    = int(percentWOnScreen * topGraph.errorValue);
      int adjustedTopMaxError = int(percentWOnScreen * maxErrorValue); // Problem here?

      if (adjustedLeftError > adjustedLeftMaxError || adjustedTopError > adjustedTopMaxError) {
        return false;
      }
    }
    return true;
  }


  void createLeftGraph() {
    // println("createLeftGraph()");

    PImage sampleLeft = sample.get(0, 0, sampleOverlap, sample.height);    
    leftGraph         = new OverlapGraph();
    leftGraph.initLeft(overlappingLeft, sampleLeft);
  }


  void createTopGraph() {
    // println("createTopGraph()");

    PImage sampleTop = sample.get(0, 0, sample.width, sampleOverlap);
    topGraph         = new OverlapGraph();
    topGraph.initTop(overlappingTop, sampleTop);
  }

  // This grabs the portion of the screen that corresponds to where 
  // this sample needs to quilt on the left. As an internal representation
  // of the overlap area, it is used to create the graph that we use
  // to run the A-star algorithm to determine the best cut.

  void createOverlappingLeft() {
    // println("createOverlappingLeft()");
    overlappingLeft = createImage(sampleOverlap, sample.height, RGB);
    overlappingLeft.loadPixels();
    int pixelIndex = 0;

    for (int i = 0; i < sample.height; i++) {
      for (int j = 0; j < sampleOverlap; j++) {
        // Get the color and store in an array
        color c = get(thisXOffset + j, thisYOffset + i);
        overlappingLeft.pixels[pixelIndex] = c;
        pixelIndex += 1;
      }
    }
  }

  // Same as above, but for use when we have to overlap on the top, too.
  void createOverlappingTop() {
    // println("createOverlappingTop()");
    overlappingTop = createImage(sample.width, sampleOverlap, RGB);
    overlappingTop.loadPixels();
    int pixelIndex = 0;
    for (int i = 0; i < sampleOverlap; i++) {
      for (int j = 0; j < sample.width; j++) {
        // Get the color and store in an array
        color c = get(thisXOffset + j, thisYOffset + i);
        overlappingTop.pixels[pixelIndex] = c;
        pixelIndex += 1;
      }
    }
  }

  // This currently only is is use for debugging purposes
  // Finds where the left and top seams cross
  OverlapNode cornerCross() {
    //println("cornerCross()");
    // Here we find where the paths overlap.
    for (OverlapNode ln : leftGraph.seam) {
      for (OverlapNode tn : topGraph.seam) {
        if (ln.isGoal || ln.isStart || tn.isGoal || tn.isStart) {
          continue;
        }
        if (ln.x == tn.x && ln.y == tn.y) {
          return ln;
        }
      }
    }

    // Uh oh. The left and top seams crossed each other without overlapping.
    // Imagine this scenario:

    // ........L......
    // TTTTT..L.......
    // .....TL.TT.....
    // .....LTT..TTTTT
    // .....L.........
    // .....L.........

    //Let's find a good match
    for (OverlapNode ln : leftGraph.seam) {
      for (OverlapNode tn : topGraph.seam) {
        if (ln.isGoal || ln.isStart || tn.isGoal || tn.isStart) {
          continue;
        }
        if (abs(ln.x - tn.x) <= 1 && abs(ln.y - tn.y) <= 1) {
          if (ln.y < tn.y) {
            return ln;
          } else {
            return tn;
          }
        }
      }
    }

    // Now we're really screwed and should throw an exception.
    // But instead, we'll just ignore this corner
    return new OverlapNode();
  }
}

