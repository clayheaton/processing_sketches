import controlP5.*;

boolean debug = true;

static int UI_PANEL_WIDTH = 255;
static int GRID_OUTER_MARGIN = 20;
static int GRID_INNER_MARGIN = 20;

static float SCALE_MIN = 0;
static float SCALE_MAX = 1.0;

static float ROTATION_MIN = 0;
static float ROTATION_MAX = TWO_PI;

static int MIN_COLOR = 0;
static int MAX_COLOR = 255;

static int FLAIR_MIN_DIM = 0;
static int FLAIR_MAX_DIM = 100;
static float FLAIR_SHEAR_MIN = 0;
static float FLAIR_SHEAR_MAX = 1.0;

// See the reset function below for definitions
Range flairWidthRange, flairHeightRange, flairRotationRange, flairShearRange;
int flair_minWidth, flair_maxWidth;
int flair_minHeight, flair_maxHeight;
float flair_minRotation, flair_maxRotation;
float flair_minShear, flair_maxShear;

Range flairRedRange, flairGreenRange, flairBlueRange;
int flair_minRed, flair_maxRed;
int flair_minGreen, flair_maxGreen;
int flair_minBlue, flair_maxBlue;

ControlP5 cp5;
Grid activeGrid, flairGrid;

void setup() {
  size(1280, 720); 

  setFlairRangeValues();

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

  if (theControlEvent.isFrom("flair rotation")) {
    flair_minRotation = theControlEvent.getController().getArrayValue(0);
    flair_maxRotation = theControlEvent.getController().getArrayValue(1);
    println("flair_minRotation, flair_maxRotation: " + flair_minRotation + ", " + flair_maxRotation);
  }

  if (theControlEvent.isFrom("flair shear")) {
    flair_minShear = theControlEvent.getController().getArrayValue(0);
    flair_maxShear = theControlEvent.getController().getArrayValue(1);
    println("flair_minShear, flair_maxShear: " + flair_minShear + ", " + flair_maxShear);
  }


  if (theControlEvent.isFrom("flair red")) {
    flair_minRed = int(theControlEvent.getController().getArrayValue(0));
    flair_maxRed = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minRed, flair_maxRed: " + flair_minRed + ", " + flair_maxRed);
  }

  if (theControlEvent.isFrom("flair green")) {
    flair_minGreen = int(theControlEvent.getController().getArrayValue(0));
    flair_maxGreen = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minGreen, flair_maxGreen: " + flair_minGreen + ", " + flair_maxGreen);
  }

  if (theControlEvent.isFrom("flair blue")) {
    flair_minBlue = int(theControlEvent.getController().getArrayValue(0));
    flair_maxBlue = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minBlue, flair_maxBlue: " + flair_minBlue + ", " + flair_maxBlue);
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
  cp5.addButton("rebuild")
    .setBroadcast(false)
    .setValue(0)
    .setPosition(10 + UI_PANEL_WIDTH/2, height-40)
    .setSize(UI_PANEL_WIDTH/2 - 20, 30)
    .moveTo("global")
    .setBroadcast(true);

  // Button to reset components
  color c1 = color(240, 26, 16);
  color c2 = color(255, 0, 0);
  cp5.addButton("reset")
    .setBroadcast(false)
    .setValue(0)
    .setColorBackground(c1)
    .setColorForeground(c2)
    .setPosition(10, height-40)
    .setSize(UI_PANEL_WIDTH/2 - 20, 30)
    .moveTo("global")
    .setBroadcast(true);

  createFlairUIComponents();
}

// Functions called by controlp5 buttons
public void rebuild(int theValue) {
  activeGrid.rebuild();
}

public void reset(int theValue) {
  setFlairRangeValues();
  activeGrid.rebuild();
}

void createFlairUIComponents() {
  flairWidthRange = cp5.addRange("flair width")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 30)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .setRangeValues(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .moveTo("default")
    .setBroadcast(true);

  flairHeightRange = cp5.addRange("flair height")
    .setBroadcast(false) 
    .setPosition(10, 70)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .setRangeValues(FLAIR_MIN_DIM, FLAIR_MAX_DIM)
    .moveTo("default")
    .setBroadcast(true);

  flairRotationRange = cp5.addRange("flair rotation")
    .setBroadcast(false) 
    .setPosition(10, 110)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(ROTATION_MIN, ROTATION_MAX)
    .setRangeValues(0, 0)
    .moveTo("default")
    .setBroadcast(true);

  flairShearRange = cp5.addRange("flair shear")
    .setBroadcast(false) 
    .setPosition(10, 150)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(FLAIR_SHEAR_MIN, FLAIR_SHEAR_MAX)
    .setRangeValues(0, 0)
    .moveTo("default")
    .setBroadcast(true);

  flairRedRange = cp5.addRange("flair red")
    .setBroadcast(false) 
    .setPosition(10, 190)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("default")
    .setBroadcast(true);

  flairRedRange = cp5.addRange("flair green")
    .setBroadcast(false) 
    .setPosition(10, 230)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("default")
    .setBroadcast(true);

  flairRedRange = cp5.addRange("flair blue")
    .setBroadcast(false) 
    .setPosition(10, 270)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("default")
    .setBroadcast(true);
}

public void setFlairRangeValues() {
  flair_minWidth  = FLAIR_MIN_DIM;
  flair_maxWidth  = FLAIR_MAX_DIM;
  flair_minHeight = FLAIR_MIN_DIM;
  flair_maxHeight = FLAIR_MAX_DIM;
  flair_minRotation = 0;
  flair_maxRotation = 0;
  flair_minShear = 0;
  flair_maxShear = 0;
  flair_minRed = MIN_COLOR;
  flair_maxRed = MAX_COLOR;
  flair_minGreen = MIN_COLOR;
  flair_maxGreen = MAX_COLOR;
  flair_minBlue = MIN_COLOR;
  flair_maxBlue = MAX_COLOR;

  try {
    flairWidthRange.setRangeValues(flair_minWidth, flair_maxWidth);
    flairHeightRange.setRangeValues(flair_minHeight, flair_maxHeight);
    flairRotationRange.setRangeValues(flair_minRotation, flair_maxRotation);
    flairShearRange.setRangeValues(flair_minShear, flair_maxShear);
    flairRedRange.setRangeValues(flair_minRed, flair_maxRed);
    flairGreenRange.setRangeValues(flair_minGreen, flair_maxGreen);
    flairBlueRange.setRangeValues(flair_minBlue, flair_maxBlue);
  }
  catch(NullPointerException e) {
  }
  finally {
  }
}