boolean debug  = true;

PFont debugFont;

int gridAcross = 10;
int gridDown   = 10;

Grid grid;

void setup(){
  size(800,800);
  
  // Set up fonts
  debugFont = createFont("Consolas",10);
  
  // Establish the grid
  grid = new Grid(gridDown,gridAcross);

  background(255);
}

void draw(){
  background(255);
  grid.display();
}