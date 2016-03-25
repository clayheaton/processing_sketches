class WangTileMaker {
  PImage sourceImage, safeRotatedSource;
  int leftRightNum, topBottomNum;
  ArrayList<WangColorSample> colorSamplesLR;
  ArrayList<WangColorSample> colorSamplesTB;

  float sampleSizeFactor = 1.1;

  ArrayList<WangTile> finalTiles;

  ArrayList<String> colors;
  ArrayList<String> colorHexCodes;

  int tilesCreated = 0;

  WangTile workingTile;
  boolean placeLeft, placeTop, placeBottom, placeRight, captureTile;

  WangTileMaker(PImage _sourceImage) {
    sourceImage = _sourceImage;

    // Used for tracking which tile we're trying to create
    workingTile = null;

    // Used for looping through and stitching colors
    placeLeft   = false;
    placeTop    = false;
    placeBottom = false;
    placeRight  = false;
    captureTile = false;

    // This isn't necessary and slows things down but is here for
    // explanatory purposes. We can use colors as sides when debugging.

    colors = new ArrayList<String>();
    colors.add("blue");
    colors.add("red");
    colors.add("green");
    colors.add("brown");
    colors.add("purple");
    colors.add("yellow");
    colors.add("black");
    colors.add("puce");
    colors.add("orange");
    colors.add("magenta");

    colorHexCodes = new ArrayList<String>();
    colorHexCodes.add("#0000FF");
    colorHexCodes.add("#FF0000");
    colorHexCodes.add("#00FF00");
    colorHexCodes.add("#8B4513");
    colorHexCodes.add("#800080");
    colorHexCodes.add("#FFD700");
    colorHexCodes.add("#333333");
    colorHexCodes.add("#722F37");
    colorHexCodes.add("#FF7F00");
    colorHexCodes.add("#FF00FF");
  }

  /*
  See the paper in the data folder for an explanation of what is happening here.
   In short, we'll create a tileset that we will use by placing the upper-left tile
   first, and then filling across the top row (matching on the left), then moving
   to the following row, matching on the top and left. In order to create a tileset
   that displays stochastic tiling, we need to make sure there are multiple options
   for each Left-Top matching, so that we can use a random number generator to pick
   a tile each time we need to place one. 
   
   We assign 'colors' to the tiles sides and determine how many colors we will use
   for the top-bottom and left-right. For each unique combination of left-top colors,
   we want at least two different bottom-right combinations. For a minimal stochastic set, we
   should have two tiles for each left-top color combination.
   
   The original paper suggests that we take diamond shaped samples from the original image.
   However, our image quilting algorithm, which we have to use again to stitch together the
   samples, works with square samples. Because of this, we'll do the following:
   1. Rotate the sourceImage by 45 degrees.
   2. Take square samples and give them color codes.
   3. Quilt together the square samples.
   4. Rotate the resulting image back 45 degrees to a diamond
   5. Take a square sample from the middle of the diamond: a Wang tile.
   6. Repeat this process for each Wang tile we need.
   */

  // Avoid going over 3 for each of these parameters
  void makeWangTileSet(int _numTopBottomColors, int _numLeftRightColors) {
    println("Making Wang tile set with " + _numTopBottomColors + " on the top and bottom and " + _numLeftRightColors + " on the left and right.");
    leftRightNum = _numLeftRightColors;
    topBottomNum = _numTopBottomColors;
  }

  void displayRotatedSource() {
    println("WangTileMaker.displayRotatedSource()");
    background(0);
    pushMatrix();
    translate(width/2, -height*sqrt(2)*(1/8.0));
    rotate(PI/4.0);
    image(sourceImage, 0, 0);
    popMatrix();
  }

  void getSafeRotatedSource() {
    println("WangTileMaker.getSafeRotatedSource()");
    safeRotatedSource = get(width * 1/6, height * 1/6, width * 2/3, height * 2/3);
  }

  void makeWangColorSamples() {
    println("WangTileMaker.makeWangColorSamples()");

    colorSamplesLR = new ArrayList<WangColorSample>();
    colorSamplesTB = new ArrayList<WangColorSample>();

    for (int i = 0; i < leftRightNum; i++) {
      WangColorSample wcs = new WangColorSample(safeRotatedSource, colors.get(i), (int)(wangTileDimension*sampleSizeFactor));
      wcs.c = color(unhex("FF" + colorHexCodes.get(i).substring(1)));
      colorSamplesLR.add(wcs);
      println("LeftRight: " + wcs.colorname);
    }

    // Strange indexing here is to get the appropriate color name
    for (int i = leftRightNum; i < (leftRightNum + topBottomNum); i++) {
      WangColorSample wcs = new WangColorSample(safeRotatedSource, colors.get(i), (int)(wangTileDimension*sampleSizeFactor));
      wcs.c = color(unhex("FF" + colorHexCodes.get(i).substring(1)));
      colorSamplesTB.add(wcs);
      println("TopBottom: " + wcs.colorname);
    }
  }


  // Just for explanatory purposes
  void showWangColorSamples() {
    background(0);

    int yPos = wangTileDimension;

    fill(255);
    textSize(20);
    text("Left / Right 'Color' Samples", 2 * wangTileDimension + 10, yPos - 20);

    for (int i = 0; i < colorSamplesLR.size (); i++) {
      int xPos = (i+1) * 2 * wangTileDimension + 10; 
      WangColorSample wcs = colorSamplesLR.get(i); 
      image(wcs.imageSample.sample, xPos, yPos);
      text(wcs.colorname, xPos, yPos + (wangTileDimension * 2) + 5);
    }

    yPos = wangTileDimension * 5; 

    text("Top / Bottom 'Color' Samples", 2 * wangTileDimension + 10, yPos - 20);

    for (int i = 0; i < colorSamplesTB.size (); i++) {
      int xPos = (i+1) * 2 * wangTileDimension + 10; 
      WangColorSample wcs = colorSamplesTB.get(i); 
      image(wcs.imageSample.sample, xPos, yPos);
      text(wcs.colorname, xPos, yPos + (wangTileDimension * 2) + 5);
    }
  }

  void establishWangTileObjects() {
    println("establishWangTileObjects()");
    /* 
     Here we create partial tiles that have all possible combinations of left/top and right/bottom colors.
     For tiling, we're only really concerned that we have more than one of each left/top combination, since
     we are going to tile starting in the upper-left and work across and down in raster scan style. The 
     additional varity on right/bottom is just to allow for a stochastic (and subsequently aperiodic) tiling.
     */
    ArrayList<WangTile> partialTilesLeftTop     = new ArrayList<WangTile>();
    ArrayList<WangTile> partialTilesRightBottom = new ArrayList<WangTile>();

    for (int i = 0; i < colorSamplesLR.size (); i ++) {
      for (int j = 0; j < colorSamplesTB.size (); j++) {
        WangTile wt = new WangTile();
        wt.left     = colorSamplesLR.get(i);
        wt.top      = colorSamplesTB.get(j);
        partialTilesLeftTop.add(wt);

        WangTile wt2 = new WangTile();
        wt2.right    = colorSamplesLR.get(i);
        wt2.bottom   = colorSamplesTB.get(j);
        partialTilesRightBottom.add(wt2);
      }
    }

    /* 
     Now, for each tile that we have in the partialTilesLeftTop ArrayList, we have to create two 
     or more tiles that have the same left/top but different right/bottom combinations. 
     
     */
    finalTiles = new ArrayList<WangTile>();

    for (WangTile wt : partialTilesLeftTop) {

      if (maximizeWangSet == true) {
        for (WangTile wt2 : partialTilesRightBottom) {
          WangTile wtf = new WangTile();
          wtf.left   = wt.left;
          wtf.top    = wt.top;
          wtf.right  = wt2.right;
          wtf.bottom = wt2.bottom;
          finalTiles.add(wtf);
        }
      } else {
        ArrayList<WangTile> used = new ArrayList<WangTile>();
        for (int i = 0; i < maxWangVariationsPerLeftTopTile; i++) {
          int r = int(random(partialTilesRightBottom.size()));
          WangTile wt2 = partialTilesRightBottom.get(r);
          while (used.contains (wt2)) {
            r   = int(random(partialTilesRightBottom.size()));
            wt2 = partialTilesRightBottom.get(r);
          }
          used.add(wt2);
          WangTile wtf = new WangTile();
          wtf.left   = wt.left;
          wtf.top    = wt.top;
          wtf.right  = wt2.right;
          wtf.bottom = wt2.bottom;
          finalTiles.add(wtf);
        }
      }
    }
  }

  void stitchTile() {

    int baselineX = int((width*0.5) -  (wangTileDimension*sampleSizeFactor) + (sampleOverlap*0.5));
    int baselineY = int((height*0.5) - (wangTileDimension*sampleSizeFactor) + (sampleOverlap*0.5));

    // Check if we're done
    if (tilesCreated == finalTiles.size()) {
      tilesAllCreated = true;
      println("Tiles all created!");
      return;
    }

    // Initialize
    if (null == workingTile) {
      // Clear the background
      background(0);

      // Get a tile reference
      workingTile = finalTiles.get(tilesCreated);
      placeLeft   = true;
    } else if (null != workingTile && placeLeft == true) {
      // Move to the next tile.
      background(0);
      workingTile = finalTiles.get(tilesCreated);
    }

    if (placeLeft) {
      // println("placeLeft");
      xOffset   = baselineX;
      yOffset   = baselineY;
      row    = 0;
      column = 0;

      // Upper left doesn't need to stitch
      workingTile.left.imageSample.createSample(xOffset, yOffset);
      fill(workingTile.left.c);
      noStroke();
      rect(xOffset - 10, yOffset - 10, 20, 20);
      noFill();
      PImage l = workingTile.left.imageSample.sample;
      image(l, xOffset, yOffset);
      placeLeft = false;
      placeTop  = true;
      return;
    }

    if (placeTop) {
      // println("placeTop");
      xOffset = baselineX + int(wangTileDimension*sampleSizeFactor) - sampleOverlap;
      yOffset = baselineY;
      row     = 0;
      column  = 1;

      workingTile.top.imageSample.createSample(xOffset, yOffset);

      fill(workingTile.top.c);
      noStroke();
      rect(xOffset + workingTile.top.imageSample.sample.width - sampleOverlap*0.5 + 5, yOffset - 10, 20, 20);
      noFill();


      workingTile.top.imageSample.placeTile(xOffset, yOffset);
      placeTop    = false;
      placeBottom = true;
      return;
    }

    if (placeBottom) {
      // println("placeBottom");
      xOffset   = baselineX;
      yOffset   = baselineY + int(wangTileDimension*sampleSizeFactor) - sampleOverlap;
      row    = 1;
      column = 0;

      workingTile.bottom.imageSample.createSample(xOffset, yOffset);

      fill(workingTile.bottom.c);
      noStroke();
      rect(xOffset -10, yOffset + workingTile.bottom.imageSample.sample.width - sampleOverlap*0.5 + 5, 20, 20);
      noFill();

      workingTile.bottom.imageSample.placeTile(xOffset, yOffset);
      placeBottom = false;
      placeRight  = true;
      return;
    }

    if (placeRight) {
      // println("placeRight");
      xOffset   = baselineX + int(wangTileDimension*sampleSizeFactor) - sampleOverlap;
      yOffset   = baselineY + int(wangTileDimension*sampleSizeFactor) - sampleOverlap;
      row    = 1;
      column = 1;

      workingTile.right.imageSample.createSample(xOffset, yOffset);

      fill(workingTile.right.c);
      noStroke();
      rect(xOffset + workingTile.right.imageSample.sample.width - sampleOverlap*0.5 + 5, yOffset + workingTile.right.imageSample.sample.width - sampleOverlap*0.5 + 5, 20, 20);
      noFill();

      workingTile.right.imageSample.placeTile(xOffset, yOffset);
      placeRight  = false;
      captureTile = true;
      return;
    }

    if (captureTile) {
      rotateAndCaptureTile();
      tilesCreated += 1;
      captureTile = false;
      placeLeft = true;
      return;
    }
  }

  void rotateAndCaptureTile() {
    // Get the image
    int baselineX = int((width*0.5) -  (wangTileDimension*sampleSizeFactor) + (sampleOverlap*0.5)) - 10;
    int baselineY = int((height*0.5) - (wangTileDimension*sampleSizeFactor) + (sampleOverlap*0.5)) - 10;

    // Get the stitched image
    PImage stitched = get(baselineX, baselineY, int(wangTileDimension*sampleSizeFactor*2 - sampleOverlap)+20, int(wangTileDimension*sampleSizeFactor*2 - sampleOverlap)+20);

    // Clear the screen, rotate, place the stitched image
    background(0);
    pushMatrix();
    translate(width*0.5, height*0.5);
    rotate(-PI/4.0);
    image(stitched, -wangTileDimension*sampleSizeFactor + sampleOverlap*0.5 - 10, -wangTileDimension*sampleSizeFactor + sampleOverlap*0.5 - 10);
    popMatrix();

    // Capture the Wang Tile. Phew!
    PImage theMotherFlippinTile = get(int(width*0.5 - wangTileDimension*0.5), int(height*0.5 - wangTileDimension*0.5), wangTileDimension, wangTileDimension);

    // Show where it was on the screen
    noFill();
    stroke(255);
    rect(width*0.5 - wangTileDimension*0.5, height*0.5 - wangTileDimension*0.5, wangTileDimension, wangTileDimension);

    /* If you want to display the actual tile...
     background(0);
     image(theMotherFlippinTile,width*0.5 - wangTileDimension*0.5, height*0.5 - wangTileDimension*0.5);
     */

    // Save the tile   
    String name = "wangtile_" + appendedTileName + "_" + workingTile.left.colorname + "_" + workingTile.top.colorname + "_" + workingTile.bottom.colorname + "_" + workingTile.right.colorname + ".png";

    theMotherFlippinTile.save(name);
  }
}

