import controlP5.*;

boolean debug = true;

static int UI_PANEL_WIDTH = 255;
static int GRID_OUTER_MARGIN = 20;
static int GRID_INNER_MARGIN = 20;

static float SCALE_MIN = 0;
static float SCALE_MAX = 1.0;

static int MIN_COLOR = 0;
static int MAX_COLOR = 255;

static int FLAIR_MIN_DIM = 0;
static int FLAIR_MAX_DIM = 100;
static float FLAIR_SHEAR_MIN = 0;
static float FLAIR_SHEAR_MAX = 1.0;

int flair_minWidth  = FLAIR_MIN_DIM;
int flair_maxWidth  = FLAIR_MAX_DIM;
int flair_minHeight = FLAIR_MIN_DIM;
int flair_maxHeight = FLAIR_MAX_DIM;

int flair_minRed = MIN_COLOR;
int flair_maxRed = MAX_COLOR;
int flair_minGreen = MIN_COLOR;
int flair_maxGreen = MAX_COLOR;
int flair_minBlue = MIN_COLOR;
int flair_maxBlue = MAX_COLOR;

float flair_minShear = FLAIR_SHEAR_MIN;
float flair_maxShear = FLAIR_SHEAR_MAX;

ControlP5 cp5;
Grid activeGrid, flairGrid;

void setup() {
  size(1280, 720); 

  // Set up the Grids
  flairGrid = new Grid(5, 3, "flair");
  activeGrid = flairGrid;
  setupControls();
  background(255);
}


void draw() {
  background(255);
  drawUIPanel();
  flairGrid.display();
}

void drawUIPanel() {
  noStroke();
  fill(128);
  rect(0, 0, UI_PANEL_WIDTH, height);
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("flair width")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    flair_minWidth = int(theControlEvent.getController().getArrayValue(0));
    flair_maxWidth = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minWidth, flair_maxWidth: " + flair_minWidth + ", " + flair_maxWidth);
  }

  if (theControlEvent.isFrom("flair height")) {
    flair_minHeight = int(theControlEvent.getController().getArrayValue(0));
    flair_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minHeight, flair_maxHeight: " + flair_minHeight + ", " + flair_maxHeight);
  }
}

void setupControls() {
  cp5 = new ControlP5(this);
  cp5.getTab("default").activateEvent(true).setLabel("flair").setId(1);
  cp5.addTab("cockpits").activateEvent(true).setId(2);
  cp5.addTab("wings").activateEvent(true).setId(3);
  cp5.addTab("segments").activateEvent(true).setId(4);
  cp5.addTab("tails").activateEvent(true).setId(5);
  cp5.addTab("ships").activateEvent(true).setId(6);
  cp5.addTab("armadas").activateEvent(true).setId(7);

  // Button to trigger redrawing of components
  cp5.addButton("rebuild").setBroadcast(false).setValue(0).setPosition(10, height-40).setSize(UI_PANEL_WIDTH - 20, 30).moveTo("global").setBroadcast(true);

  cp5.addRange("flair width")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 30)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .setRangeValues(20, 80)
    .moveTo("default")
    .setBroadcast(true);

  cp5.addRange("flair height")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 70)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .setRangeValues(20, 80)
    .moveTo("default")
    .setBroadcast(true);
}

// function colorA will receive changes from 
// controller with name colorA
public void rebuild(int theValue) {
  activeGrid.rebuild();
}