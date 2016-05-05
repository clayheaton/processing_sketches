import java.util.Collections;

boolean debug = true;

// This is important - it will be the cell dimensions
int unit_size = 16;

WorldGrid worldGrid;
Database database;
ClickHandler clickHandler;

void setup() {
  size(800, 800);
  pixelDensity(2);
  background(255);
  noStroke();
  fill(0);

  worldGrid = new WorldGrid(0, 0, width, height, width/unit_size, height/unit_size);
  worldGrid.drawGrid = true;

  database = new Database();
  database.loadGameObjects("GameObjects.csv");
  database.loadDormRoomTemplates("blueprints_dorm_rooms.csv");

  clickHandler = new ClickHandler();
}

void draw() {
  background(255);
  worldGrid.display();

  for (PlacedGameObject pgo : database.placedGameObjects){
    pgo.display();
  }
  
}

void mousePressed(){
    clickHandler.placeDormRoomTemplate();
}

void printDebug(String str) {
  if (debug) {
    println(str);
  }
}

void printDebugBreak() {
  if (debug) {
    printDebug("---------------------------------");
  }
}