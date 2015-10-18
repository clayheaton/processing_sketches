PImage img;
boolean record;
int scalePG=4;
int leafMax = 200;

// Set the background color in one place
color bgColor         = color(4, 52, 118);
color haloColor       = #5F5F69;
color leafStrokeColor = color(200);

// A variable we use to pause the drawing
boolean paused = true;
int across = 200;
int down = 300;

void setup() {
  size(600, 600);
  img = loadImage("large_moon_04.png");
  
  background(bgColor);
  
  stroke(leafStrokeColor); // make the lines pale grey
  strokeWeight(0.5); // make the lines thin
}

void draw() {
 if(!record)
  background(bgColor);
 // big.background(bgColor);
  // Draw the moon and the halos around it
  drawMoon();
 // Draw the bamboo
  drawBamboo();  
  // Use this for loop to draw the leaves
  for (int leaves = 0; leaves < leafMax; leaves++) {
    float cx = 300 + random(-275, 275); // here's a variable that is within a range from 150 to 450
    float cy = 300 + random(-275, 275); // here's a variable that is within a range from 150 to 450

    // You almost always want to use pushMatrix()
    // and popMatrix() when you use translate, rotate, and scale
    pushMatrix(); 
    translate(cx, cy);
    rotate(random(TWO_PI));
    scale(random(0.9, 1.8));
    drawLeaf();
    popMatrix();

  }

  // Don't draw again until we click the mouse
  noLoop();
 // big.endDraw();                             // Stop drawing to the PGraphics object 
  //big.save("big.tif");

}
void drawBamboo(){
    stroke(0);
    noFill();
    strokeWeight(8); 
  curve(100, 1000, 500, 700, 200, 300, 200, 700);
   strokeWeight(5);
    curve(600, 700, 450, 600, 600, 300, 600, 400);
     strokeWeight(12);
    curve(100, 1000, 500, 700, 400, 0, 50, 200);
   //adding blue rectagle to make the edge of curve1 pointy
    pushMatrix();
    translate(210, 285);
    rotate(radians(75));
    fill(bgColor);
    stroke(bgColor);
    rect(0, 0, 10, 40);
    popMatrix();
}

void drawMoon() {
  int moonX = width/2;
  int moonY = height/4;
  int moonDimension = int(width/4.2);

  // Place the halo behind the moon
  // Note: this probably could use some tweaking
  int gradientHeight = int(moonDimension / 1.2);
  int gradientWidth  = int(moonDimension * 2);

  int topHaloY    = int(moonY + (moonDimension*0.25));
  int midHaloY    = int(moonY + (moonDimension*0.5));
  int bottomHaloY = int(moonY + (moonDimension*0.85));

  // Halo at the top
  drawHaloCircle(moonX+(moonDimension/2), topHaloY, int(gradientWidth*0.8), gradientHeight, bgColor, haloColor);

  // Halo at the middle
  drawHaloCircle(moonX+(moonDimension/2), midHaloY, gradientWidth, int(gradientHeight*1.5), bgColor, haloColor);

  // Halo at the bottom
  drawHaloCircle(moonX+(moonDimension/2), bottomHaloY, int(gradientWidth*0.8), gradientHeight, bgColor, haloColor);

  // place the image of the moon on top of the halos
  image(img, moonX, moonY, moonDimension, moonDimension);

  // Draw another halo over moon
  drawHaloCircle(moonX+(moonDimension/2), moonY+(moonDimension/2), int(moonDimension*1.5), int(moonDimension*1.5), bgColor, haloColor);
}

void drawHaloCircle(int _x, int _y, int _w, int _h, color _outerColor, color _innerColor) {
  // See the radial gradient example page
  // https://processing.org/examples/radialgradient.html
  
  // Change the blend mode so the halos blend well
  blendMode(LIGHTEST);
  // Is the _w or _h smaller?
  int smallerDimension = _w < _h ? _w : _h;
  float colorLerpAmount = 1.0/smallerDimension;

  // Figure out the ratio of the width and height to the 
  // smaller dimension that we discovered
  float wRatio = (float)_w/smallerDimension;
  float hRatio = (float)_h/smallerDimension;

  // Adjust the ratios for more texture in the halo
  wRatio = wRatio > 1.0 ? 1.0 + (0.3*abs(1.0 - wRatio)) : wRatio;
  hRatio = hRatio > 1.0 ? 1.0 + (0.3*abs(1.0 - hRatio)) : hRatio;

  // We create a halo by using a radial gradient, which means
  // that we draw a series of circles inside of each other
  // that change colors from the background color to the 
  // color of the halo on the original image
  for (int d = smallerDimension; d > 0; --d) {

    // Interpolate between the outer and inner colors of the 
    // gradient to create an effect that mimics the halo 
    // around the moon from the original picture.
    float lerpAmount = 1 - d*colorLerpAmount;
    color fillColor  = lerpColor(_outerColor, _innerColor, lerpAmount);
    fill(red(fillColor), green(fillColor), blue(fillColor));
    noStroke();

    // As we pass through the loop, we have to decrease the ellipse
    // dimensions to create the gradient effect.
    int diff = smallerDimension - d;
    float ellipseWidth  = _w - (diff*wRatio);
    float ellipseHeight = _h - (diff*hRatio);
    ellipse(_x, _y, ellipseWidth, ellipseHeight);
  }
  // Return to default blend mode so the leaves draw properly
  blendMode(BLEND);
}

void drawLeaf() {
  float pointShift = random(-20, 20); // here is a variable between -20 and 20
  fill(random(235), 200);
  stroke(leafStrokeColor);
  strokeWeight(0.5);
  beginShape(); // start to draw a shape
  vertex(20, 45); // begin at this point x, y
  bezierVertex(30, 30, 60 + pointShift, 40 + pointShift/2, 70 + pointShift, 50); // make the pointy end of the leaf vary on the x axis (so the leaf gets longer or shorter) AND vary the y axis of the control points by the same amount. It should be possible to have 'normal' leaves, very short fat ones and very long thin ones.
  bezierVertex(60 + pointShift, 55, 30, 65, 20, 45); // draw the other half of the shape
  endShape();
}

void mousePressed() {
  // When we click the mouse, we use the mouseY
  // position to set the number of leaves and 
  // we tell Processing to go through the draw()
  // loop again.
  leafMax = 1 + mouseY/3;
  loop();
}

void keyPressed() { //hopefully saving to a .png
    if(keyCode == ENTER) {
        PGraphics PGpx = createGraphics(width*scalePG, height*scalePG);
        record = true;
        beginRecord(PGpx);
        PGpx.background(bgColor); //no change if commented out
        PGpx.scale(scalePG);
        draw();
        PGpx.save("bambooPossibly.png"); 
        endRecord();
        record = false;
    }
}