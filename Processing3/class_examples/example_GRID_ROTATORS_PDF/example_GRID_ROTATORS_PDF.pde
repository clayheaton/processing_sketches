import processing.pdf.*;

boolean debug  = false;
boolean recording = false;
boolean doExit = false;

PFont debugFont;

int gridAcross = 6;
int gridDown   = 1;

int theMargin  = 25;

boolean pause;

Grid grid;

void setup() {
  size(650, 150);

  randomSeed(11252015);

  // Set up fonts
  debugFont = createFont("Consolas", 6);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, theMargin);

  background(255);
  strokeCap(SQUARE);

  pause = false;
}

void draw() {
  background(255);
  
  if (pause){
    beginRecord(PDF, "output.pdf");
    noStroke();
    background(255);
    grid.debugDisplay();
  }
  
  
  grid.display();

  if (pause) {
    noLoop(); 
    endRecord();
    exit();
  }
}

void mouseClicked() {
  pause = !pause;
  loop();
}

void keyPressed() {
  pause = !pause;
  loop();
}