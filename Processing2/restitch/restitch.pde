PImage grass, grass2;

int canvasSize    = 768;
int sampleSize    = 96;
int overlapFactor = 6; // 6 for 1/6th of the sample size. 8 for 1/8th, etc.

int sampleOverlap = sampleSize / overlapFactor;

// Needed to cover the canvas
int columns, rows;

// Counters for tracking position
int column, row;
int xOffset, yOffset, offsetAmount;

// For tracking progress
boolean drawIt   = false;
boolean complete = false;

void setup() {
  size(canvasSize, canvasSize);
  background(0);

  grass  = loadImage("grass.png");
  grass2 = loadImage("grass2.png");

  columns = 1 + width  / (sampleSize - sampleOverlap);
  rows    = 1 + height / (sampleSize - sampleOverlap);

  // Counters
  column  = 0;
  row     = 0;

  offsetAmount = sampleSize - sampleOverlap;
}

void draw() {
  if (drawIt && !complete) {
    xOffset = column * offsetAmount;
    yOffset = row    * offsetAmount; 


    if (column == 0 && row == 0) {
      Sample s = new Sample(grass);
      PImage i = s.sample;
      image(i, xOffset, yOffset);
    } else {
      Sample s = new Sample(grass);
      PImage i = s.sample;
      image(i, xOffset, yOffset);
    }

    // For loop replacement means updating column and row
    column += 1;
    if (column == columns) {
      column = 0;
      row += 1;
    }
    
    // We are done with row == rows
    if (row == rows){
     complete = true; 
     println("Finished!");
    }

    drawIt = false;
  }
}

void mouseClicked() {
  drawIt = true;
}

