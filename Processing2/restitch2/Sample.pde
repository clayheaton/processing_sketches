class Sample {
  PImage sample, overlappingLeft, overlappingTop;

  Sample(PImage _source) {
    int sample_x_start = int(random(0, _source.width  - sampleSize));
    int sample_y_start = int(random(0, _source.height - sampleSize));
    sample = _source.get(sample_x_start, sample_y_start, sampleSize, sampleSize);
  }

  // TODO: Create the graphs, calculate the paths
  // TODO: Calculate errors along paths, determine whether cuts are within tolerance.
  boolean calculateOverlapCuts() {
    if (row == 0 && column > 0) {
      createOverlappingLeft();
    }

    if (row > 0 && column == 0) {
      createOverlappingTop();
    }

    if (row > 0 && column > 0) {
      createOverlappingLeft();
      createOverlappingTop();
    }
    return true;
  }



  // This grabs the portion of the screen that corresponds to where 
  // this sample needs to quilt on the left. As an internal representation
  // of the overlap area, it will be used to create the graph that we use
  // to run Dykstra's algorithm to determine the best cut.

  void createOverlappingLeft() {
    overlappingLeft = createImage(sampleOverlap, sample.height, RGB);
    overlappingLeft.loadPixels();
    int pixelIndex = 0;

    for (int i = 0; i < sample.height; i++) {
      for (int j = 0; j < sampleOverlap; j++) {
        // Get the color and store in an array
        color c = get(xOffset + j, yOffset + i);
        overlappingLeft.pixels[pixelIndex] = c;
        pixelIndex += 1;
      }
    }

    overlappingLeft.updatePixels();
    image(overlappingLeft, width/2, height/2);
  }

  // Same as above, but for use when we have to overlap on the top, too.
  void createOverlappingTop() {
    overlappingTop = createImage(sample.width, sampleOverlap, RGB);
    overlappingTop.loadPixels();
    int pixelIndex = 0;
    for (int i = 0; i < sampleOverlap; i++) {
      for (int j = 0; j < sample.width; j++) {
        // Get the color and store in an array
        color c = get(xOffset + j, yOffset + i);
        overlappingTop.pixels[pixelIndex] = c;
        pixelIndex += 1;
      }
    }

    overlappingTop.updatePixels();
    image(overlappingTop, width/2, height/2);
  }
}

