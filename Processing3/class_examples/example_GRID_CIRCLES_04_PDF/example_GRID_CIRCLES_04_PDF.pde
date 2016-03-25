import processing.pdf.*;


boolean debug  = true;
boolean recording = false;
boolean doExit = false;

PFont debugFont;

int gridAcross = 22;
int gridDown   = 12;
int theMargin  = 60;


float diameter   = 300;
// float decay      = 0.7;
// float angleDecay = 0.9;
float childAngle = 90;

int childCircles = 11;

boolean pause;

Grid grid;

void setup() {
  size(1300, 800);

  randomSeed(11251973);

  // Set up fonts
  debugFont = createFont("Consolas", 10);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, theMargin);

  background(255);
  strokeCap(SQUARE);

  pause = false;
  noStroke();
}

void draw() {
  
  if(!recording){
   recording = true;
   beginRecord(PDF,"output.pdf");
   noStroke();
  }
  grid.display();
  childAngle++;

  if (pause) {
    //grid.debugDisplay();
    noLoop();
    endRecord();
    exit();
  }
}


void mouseClicked() {
  pause = !pause;
  loop();
}