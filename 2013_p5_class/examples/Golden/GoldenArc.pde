class GoldenArc {

  PVector boxOrigin, translatedOrigin, root, translatedRoot, ellipseCenter;
  float boxWidth;
  float boxHeight;
  float boxScale;
  float arcStrokeWeight;

  float goldenWidth, halfGoldenWidth, circleDiameter;

  float rotationDegrees;

  boolean growFromRoot = false;

  // For recursively drawing them...
  boolean recursive = false;

  // For testing purposes only
  boolean drawBox;
  boolean debug = false;
  
  color thisArcColor;

  GoldenArc(float xOrigin, float yOrigin, float tempScale, float tempRotationDegrees, boolean tempGrowFromRoot, boolean recursive) {
    drawBox = false;
    thisArcColor = chosenSolidColor();


    boxOrigin = new PVector(xOrigin, yOrigin);
    translatedOrigin = new PVector(boxOrigin.x, boxOrigin.y);

    boxWidth  = picX * tempScale;
    boxHeight = boxWidth / goldenRatio;
    boxScale  = tempScale;

    arcStrokeWeight = defaultStrokeWeight * boxScale;
    rotationDegrees = tempRotationDegrees;

    /* If the incoming origin points are the origin points of a rectangle that is of the Golden Ratio, this will draw the 
     appropriate arc for the Golden Ratio if set to true */
    growFromRoot = tempGrowFromRoot;

    goldenWidth = boxHeight;
    halfGoldenWidth = goldenWidth / 2;

    // This is a little misleading -- the circleDiameter actually is the circle diameter

    circleDiameter = sqrt(sq(goldenWidth) + sq(halfGoldenWidth)) * 2;
    ellipseCenter = new PVector(halfGoldenWidth - (arcStrokeWeight / 2), boxHeight - (arcStrokeWeight / 4));

    currentArcs++;

    if (recursive && currentArcs < arcsToDraw) {
      GoldenArc nextArc = new GoldenArc(pointAlongArc(recursionPercentageChange).x, pointAlongArc(recursionPercentageChange).y, boxScale/recursionScaleDivisor, rotationDegrees - recursionRotationDegrees, true, true);
      arcArray = (GoldenArc[])append(arcArray, nextArc);
    } else {
      print("Done creating arcs\n"); 
    }
  }

  // Create a new constructor for one that will always grow from a point...

  void display() {
    pushMatrix();
    performTranslation();
    debug();
    noFill();
    stroke(thisArcColor);
    strokeWeight(arcStrokeWeight);

    if (growFromRoot) {
      arc(ellipseCenter.x - boxWidth, ellipseCenter.y - boxHeight, circleDiameter, circleDiameter, radians(goldenArcOffset), radians(goldenArcEnd));
    } 
    else {
      arc(ellipseCenter.x, ellipseCenter.y, circleDiameter, circleDiameter, radians(goldenArcOffset), radians(goldenArcEnd));
    }
    fill(0);
    
    popMatrix();
  }

  PVector pointAlongArc(float percentageFromRoot) {
    pushMatrix();
    performTranslation();
    float angle = goldenArcOffset * percentageFromRoot/100;

    float x = (cos(radians(angle)) * circleDiameter/2) + ellipseCenter.x;
    float y = (sin(radians(angle)) * circleDiameter/2) + ellipseCenter.y;

    if (growFromRoot) {
      x -= boxWidth;
      y -= boxHeight;
    }
    if (debug) {
      fill(0);
      stroke(155);
      strokeWeight(1);
      ellipse(x, y, 10, 10);
      line(ellipseCenter.x, ellipseCenter.y, x, y);
    }

    PVector thePoint = new PVector(screenX(x, y), screenY(x, y));
    
    popMatrix();
    return thePoint;
  }

  void performTranslation() {
    translate(boxOrigin.x, boxOrigin.y);
    rotate(radians(rotationDegrees));
    translatedOrigin.x = 0;
    translatedOrigin.y = 0;
  }

  // DEBUGGING
  void debug() {
    if (drawBox) {
      drawBox();
    }
  }

  void drawBox() {
    stroke(color(#ff0000));
    noFill();
    strokeWeight(1);
    rectMode(CORNER);
    rect(translatedOrigin.x, translatedOrigin.y, boxWidth, boxHeight);
  }
}

