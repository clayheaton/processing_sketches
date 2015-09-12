/*

 Image Quilting, by Clay Heaton, 2015.
 
 This sketch provides an example implementation of the image quilting 
 algorithm described by Alexei Efros and William Freeman in their 
 oft-cited paper from 2001. A copy of the paper is included in the 
 sketch's data folder. Look here for more info:
 http://www.eecs.berkeley.edu/~efros/
 
 From one or two original images (that should be similar, if using two),
 the algorithm "quilts" together samples from those images, seeking the 
 overlap seams between samples that minimizes the color differences. 
 Given the appropriate input image, the effect is that this can create 
 larger images, of arbitrary size, that do not look like they were 
 assembled by tiling the original image. 
 
 The A* algorithm is used to find the lowest-cost seam in overlap
 areas, vs. Dijkstra's, as described in the original paper. This
 works because we insert dummy "start" and "end" nodes in the graph
 constructed from overlapping pixels, then prune them away when we
 have found the minimal path between them. I couldn't figure out
 why there would be any advantage to the computational overhead
 of Dijkstra. My A* heuristic is lame, but it still works. :)
 
 */

import java.util.PriorityQueue;

// Not used in Processing 3
int canvasSize = 1000; // will be square

// Set to true if you want to see debug information 
boolean debug = true;

// Declare test images - they are loaded in setup()
PImage grass, grass2, grass3, mars, mars2, water, apples, muddywater, gravel, gravel2, gravel3;
PImage crackedmud1, crackedmud2;

// Textures to use for the run of the sketch
// ASSIGN THEM BELOW!!!!! in the setup() function below (Processing requirement)
PImage texture1;
PImage texture2;

// % chance that a pixel will be drawn from texture1 vs. texture2
float texture1Chance = 0.8;

int sampleSize       = 64; // Side length of samples taken from original source
int overlapFactor    = 3;  // 6 for 1/6th of the sample size. 8 for 1/8th, etc.
int sampleOverlap    = sampleSize / overlapFactor; // Don't change this.

// How similar do the overlapping sections need to be?
// Low error tolerance, such as 0.15, means there can only be 15% of the max error
// represented in the overlap region of the samples.
// Typical ranges are 0.1 - 0.3, but they vary.
float overlapErrorTolerance = 0.15;

// Error Calculations - don't change these
int maxError      = int(sq(255) + sq(255) + sq(255)) * sampleSize * sampleOverlap; // num pixels * max error per pixel
int maxErrorValue = int(maxError * overlapErrorTolerance);


// Used to support debugging
ArrayList<PVector> debugLines;

// Background color defaults to black.
color bgColor = color(0, 0, 0);

// Needed to cover the canvas; don't change.
int columns, rows;

// Counters for tracking position; don't change.
int column, row;
int xOffset, yOffset, offsetAmount;

// For tracking progress; don't change.
boolean complete      = false;
boolean grabbedFinal  = false;

// Keep the final image; don't change.
PImage finalImage;

void setup() {
  size(1000, 1000);
  background(bgColor);

  // Load test images
  grass      = loadImage("grass.png");
  grass2     = loadImage("grass2.png");
  grass3     = loadImage("grass3.png");
  mars       = loadImage("mars.png");
  mars2      = loadImage("mars2.png");
  water      = loadImage("water.png");
  apples     = loadImage("apples.png");
  muddywater = loadImage("muddywater.png");
  gravel     = loadImage("gravel.png");
  gravel2    = loadImage("gravel2.png");
  gravel3    = loadImage("gravel3.png");
  crackedmud1= loadImage("crackedmud1.png");
  crackedmud2= loadImage("crackedmud2.png");

  // CHANGE THESE VALUES to represent the textures you want to quilt
  // Examples:
  // Set texture1 to grass and texture2 to grass2
  // Set texture1 to gravel and texture2 to gravel
  // For a crazy image, Set texture1 to mars and texture2 to water 
  // and set the error tolerance (above) to 0.5 or so.
  texture1 = gravel3;
  texture2 = gravel3;

  // Don't change anything else in setup()
  columns = 1 + width  / (sampleSize - sampleOverlap);
  rows    = 1 + height / (sampleSize - sampleOverlap);

  // Counters
  column  = 0;
  row     = 0;

  offsetAmount = sampleSize - sampleOverlap;
  debugLines   = new ArrayList<PVector>();
  // println("maxErrorValue: " + maxErrorValue);
}

void draw() {

  ////////////////////////////////////////////////
  ////// Stuff to do when the image is complete //
  ////////////////////////////////////////////////
  
  if (complete == true && grabbedFinal == false) {
    frameRate(5);
    finalImage = createImage(width, height, RGB);
    finalImage = get(0, 0, width, height);
    grabbedFinal = true;

    if (debug == true) {
      println("Click the mouse to toggle the seam lines on and off.");
    }
  }

  if (grabbedFinal == true) {
    background(bgColor);
    image(finalImage, 0, 0);
    fill(255, 0, 0);
    noStroke();
    if (debug == true) {
      for (PVector v : debugLines) {
        rect(v.x, v.y, 1, 1);
      }
    }
  }
  
  ///////////////////////////////////////////////////////
  ////// End of Stuff to do when the image is complete //
  ///////////////////////////////////////////////////////


  ////////////////////////////////////////////////
  ////// Stuff to do to create the image /////////
  ////////////////////////////////////////////////

  // Everything below here does the quilting and draws the image
  if (!complete) {

    // This can and perhaps should be done in a for loop. However
    // it's useful to watch the quilted image unfold and provides
    // the opportunity to pause and inspect the image if we abstract
    // the for loop out of the draw() loop and manually track it 
    // instead. That is the purpose of the variables:
    // column, columns, row, and rows.

    xOffset = column * offsetAmount;
    yOffset = row    * offsetAmount; 

    Sample s;

    if (random(1) > (1-texture1Chance)) {
      s = new Sample(texture1);
    } else {
      s = new Sample(texture2);
    }

    if (column == 0 && row == 0) {
      // Initial tile doesn't have to check seams
      PImage i = s.sample;
      image(i, xOffset, yOffset);
    } else {
      s.placeTile(xOffset, yOffset);
    }

    // Tracking the "for" loop abstracted out of draw()
    column += 1;
    if (column == columns) {
      column = 0;
      row += 1;
    }

    // We are done when row == rows
    if (row == rows) {
      complete = true; 
      println("Finished!");
    }
  }
  ///////////////////////////////////////////////////////
  ////// End of Stuff to do to create the image /////////
  ///////////////////////////////////////////////////////
}

void mousePressed() {
  debug = !debug;
}

