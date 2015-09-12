boolean debug  = true;

PFont debugFont;

int gridAcross  = 4;
int gridDown    = 2;
int outerMargin = 50;
int innerMargin = 50;


float diameter   = 300;
// float decay      = 0.7;
// float angleDecay = 0.9;
float childAngle = 90;

int childCircles = 11;

boolean pause;

Grid grid;

void setup() {
  size(1200, 800);

  // Set up fonts
  debugFont = createFont("Consolas", 10);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, outerMargin, innerMargin);

  background(255);
  strokeCap(SQUARE);

  pause = false;
  noStroke();
}

void draw() {
  // background(255);
  grid.display();
  childAngle++;

  if (pause) {
    grid.debugDisplay();
    noLoop();
  }
}

void mouseClicked() {
  pause = !pause;
  loop();
}