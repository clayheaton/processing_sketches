boolean debug  = true;
boolean debugText = false;

PFont debugFont;

int gridAcross = 10;
int gridDown   = 10;

int theMargin  = 0;

Grid grid;

void setup(){
  size(800,800);
  
  // Set up fonts
  debugFont = createFont("Consolas",10);
  
  // Establish the grid
  grid = new Grid(gridDown,gridAcross, theMargin);

  background(255);
}

void draw(){
  background(255);
  grid.display();
}