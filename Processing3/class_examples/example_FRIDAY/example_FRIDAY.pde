boolean debug  = true;

PFont debugFont;

int gridAcross = 15;
int gridDown   = 5;

int theMargin  = 30;

boolean pause;

Grid grid;

void setup() {
  size(1200, 800);

  // Set up fonts
  debugFont = createFont("Consolas", 10);

  // Establish the grid
  grid = new Grid(gridDown, gridAcross, theMargin);

  background(255);
  strokeCap(SQUARE);
  
  pause = false;
}

void draw() {
  background(255);
  grid.display();
  
  if(pause){
   noLoop(); 
  }
}

void mouseClicked(){
  pause = !pause;
  loop();
}