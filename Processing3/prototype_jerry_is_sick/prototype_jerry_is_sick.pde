// 1. Establish game grid as separate from view
// 2. Allow movement on game grid through click-drag

final int GameGridWidth = 10;
final int GameGridHeight = 10;
final int GameGridPixelSize = 75;

final boolean debug = true;

final int STATE_HEALTHY    = 0;
final int STATE_INFECTED   = 1;
final int STATE_CONTAGIOUS = 2;
final int STATE_IMMUNE     = 3;
final int STATE_DEAD       = 4;

final int ATTACK_COUGH  = 0;
final int ATTACK_SNEEZE = 1;
final int ATTACK_HUG    = 2;
final int ATTACK_SPIT   = 3;
final int ATTACK_VOMIT  = 4;
final int ATTACK_KISS   = 5;

final float DIRECTION_E  = 0;
final float DIRECTION_NE = TWO_PI - PI/4;
final float DIRECTION_N  = TWO_PI - PI/2;
final float DIRECTION_NW = TWO_PI - PI/2 - PI/4;
final float DIRECTION_W  = PI;
final float DIRECTION_SW = PI - PI/4;
final float DIRECTION_S  = PI/2;
final float DIRECTION_SE = PI/4;

boolean advanceTurn = false;
float offsetX, offsetY;

Disease disease;
GameGrid gameGrid;
ArrayList<UILayer> uiLayers;

void setup() {
  //pixelDensity(2);
  size(576, 768);
  background(255);
  offsetX = 0;
  offsetY = 0;
  
  // Comment this out for random games
  randomSeed(1);

  disease  = new Disease();
  gameGrid = new GameGrid(GameGridWidth, GameGridHeight, GameGridPixelSize);
  uiLayers = new ArrayList<UILayer>();

  // Move bar at bottom
  UILayer bottomBar = new UILayer(80, color(#0D2538));
  uiLayers.add(bottomBar);
}

void draw() {
  background(255);
  pushMatrix();
  translate(offsetX, offsetY);
  gameGrid.display();
  popMatrix();

  for (UILayer l : uiLayers) {
    l.display();
  }
}

void mouseDragged() {
  if (mouseOverUI()) {
    return;
  }
  offsetX += (mouseX - pmouseX);
  offsetY += (mouseY - pmouseY);
}

void mouseClicked() {
  if (mouseOverUI()) {
    // Catch clicks on the UI Layer first
    for (UILayer l : uiLayers) {
      l.checkMouseClick();
    }
  } else {
    // Then catch clicks on the game board.
    gameGrid.selectSector();
    println(gameGrid.selectedSector);
  }
}

boolean mouseOverUI() {

  for (UILayer l : uiLayers) {
    if (l.catchingMouse() == true) {
      return true;
    }
  }

  return false;
}