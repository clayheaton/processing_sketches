// 1. Establish game grid as separate from view
// 2. Allow movement on game grid through click-drag

final int GameGridWidth = 20;
final int GameGridHeight = 20;
final int GameGridPixelSize = 75;

final boolean debug = true;

final int STATE_HEALTHY    = 0;
final int STATE_INFECTED   = 1;
final int STATE_CONTAGIOUS = 2;
final int STATE_IMMUNE     = 3;
final int STATE_DEAD       = 4;

final float DIRECTION_E  = 0;
final float DIRECTION_NE = TWO_PI - PI/4;
final float DIRECTION_N  = TWO_PI - PI/2;
final float DIRECTION_NW = TWO_PI - PI/2 - PI/4;
final float DIRECTION_W  = PI;
final float DIRECTION_SW = PI - PI/4;
final float DIRECTION_S  = PI/2;
final float DIRECTION_SE = PI/4;

float offsetX, offsetY;

GameGrid gameGrid;
ArrayList<UILayer> uiLayers;

void setup() {
  size(576, 768);
  background(255);
  offsetX = 0;
  offsetY = 0;

  gameGrid = new GameGrid(GameGridWidth, GameGridHeight, GameGridPixelSize);
  uiLayers = new ArrayList<UILayer>();
  
  // Move bar at bottom
  UILayer bottomBar = new UILayer();
  bottomBar.bgColor = color(0);
  bottomBar.pixelsTall = 80;
  uiLayers.add(bottomBar);
  
}

void draw() {
  background(255);
  pushMatrix();
  translate(offsetX, offsetY);
  gameGrid.display();
  popMatrix();
  
  for (UILayer l: uiLayers){
     l.display(); 
  }
}

void mouseDragged() {
  offsetX += (mouseX - pmouseX);
  offsetY += (mouseY - pmouseY);
}