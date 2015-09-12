boolean debug     = true;
boolean debugText = false;

PFont debugFont;

int gridAcross  = 10;
int gridDown    = 10;
int outerMargin = 0;
int innerMargin = 0;

Grid grid;

void setup(){
  size(900,900);
  
  // Set up fonts
  debugFont = createFont("Consolas",10);
  
  // Establish the grid
  grid = new Grid(gridDown,gridAcross, outerMargin, innerMargin);

  background(255);
}

void draw(){
  background(255);
  grid.display();
}