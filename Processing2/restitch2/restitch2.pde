PImage grass, grass2;

int canvasSize    = 768;
int sampleSize    = 96;
int overlapFactor = 6; // 6 for 1/6th of the sample size. 8 for 1/8th, etc.

int sampleOverlap = sampleSize / overlapFactor;

color bgColor = color(0,0,0);

// Needed to cover the canvas
int columns, rows;

// Counters for tracking position
int column, row;
int xOffset, yOffset, offsetAmount;

// For tracking progress
boolean drawIt   = false; // Stop after each draw loop
boolean paulse   = false; // For random pausing as the algorithm unfolds
boolean complete = false;

void setup() {
  size(canvasSize, canvasSize);
  background(bgColor);

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
      // Place the initial sample
      Sample s = new Sample(grass);
      PImage i = s.sample;
      image(i, xOffset, yOffset);
    } else {
      // Place all additional samples
      Sample s = new Sample(grass);
      s.calculateOverlapCuts();
      
      
    }

    // For loop replacement means updating column and row
    // This is done so that we can watch the algorithm unfold
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

