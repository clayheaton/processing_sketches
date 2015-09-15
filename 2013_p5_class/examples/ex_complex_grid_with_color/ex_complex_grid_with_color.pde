// Set the canvas size
size(600, 600);

// Create a variable with the dimensions of the grid
int numSquares = 15;

// Calculate the size of each grid square side
float gridSize = (float)width / numSquares;

// Debugging to determine size
print("The grid size is " + gridSize + ".\n");

// Set the background to white
background(255);

// Set the grid color to grey
stroke(150);

// Set the stroke width
strokeWeight(1);

// Draw the lines in a for loop
for (int i = 0; i < numSquares - 1; i++) {

  // Vertical Lines
  float x = gridSize * (i + 1);
  float y = 0;
  line(x, y, x, height);

  // Horizontal Lines
  x = 0;
  y = gridSize * (i + 1);
  line(x, y, width, y);
}

// Draw squares in the grid

// Establish the offset
float scaleOfInsetSquares = 1;
float insetSquareWidth    = gridSize * scaleOfInsetSquares;
float insetSquareOffset   = (gridSize - insetSquareWidth) / 2;

// Turn off the strokes
noStroke();

// Set the rect mode to draw from the corner
rectMode(CORNER);

for (int i = 0; i < numSquares; i++) {
  for (int j = 0; j < numSquares; j++) {
    // Set the fill
    fill(0,0,255,(255/(numSquares*numSquares)) * (i + 1) * (j + 1));
    
   float x = (j * gridSize) + insetSquareOffset;
   float y = (i * gridSize) + insetSquareOffset;
     rect(x,y,insetSquareWidth, insetSquareWidth);
  }
}


