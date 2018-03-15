import java.util.Random;
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

// See the reset function below for definitions

/*
FLAIR
 */
static int FLAIR_MIN_DIM = 0;
static int FLAIR_MAX_DIM = 100;
static float FLAIR_SHEAR_MIN = 0;
static float FLAIR_SHEAR_MAX = 1.0;

Range flairWidthRange, flairHeightRange, flairRotationRange, flairShearRange;
int flair_minWidth, flair_maxWidth;
int flair_minHeight, flair_maxHeight;
float flair_minRotation, flair_maxRotation;
float flair_minShear, flair_maxShear;

Range flairRedRange, flairGreenRange, flairBlueRange;
int flair_minRed, flair_maxRed;
int flair_minGreen, flair_maxGreen;
int flair_minBlue, flair_maxBlue;
/*
END FLAIR
 */

/*
COCKPITS
 */
static int COCKPIT_MIN_WIDTH = 50;
static int COCKPIT_MAX_WIDTH = 200;
static int COCKPIT_MIN_HEIGHT = 50;
static int COCKPIT_MAX_HEIGHT = 250;
static int COCKPIT_MIN_BAYS = 0;
static int COCKPIT_MAX_BAYS = 4;

Range cockpitWidthRange, cockpitHeightRange, cockpitBaysRange;
CheckBox cockpitCheckbox;
int cockpit_minWidth, cockpit_maxWidth;
int cockpit_minHeight, cockpit_maxHeight;
int cockpit_minBays, cockpit_maxBays;
boolean cockpit_window1, cockpit_window2;
boolean cockpit_type1, cockpit_type2, cockpit_type3;

Range cockpitRedRange, cockpitGreenRange, cockpitBlueRange;
int cockpit_minRed, cockpit_maxRed;
int cockpit_minGreen, cockpit_maxGreen;
int cockpit_minBlue, cockpit_maxBlue;

/*
END COCKPITS
 */

ControlP5 cp5;
Grid activeGrid, flairGrid, cockpitGrid;

void setup() {
  size(1280, 720); 

  setFlairRangeValues();
  setCockpitRangeValues();

  // Set up the Grids
  flairGrid = new Grid(5, 3, "flair");
  activeGrid = flairGrid;

  cockpitGrid = new Grid(4, 2, "cockpit");

  setupControls();
  background(255);
}


void draw() {
  background(255);
  drawUIPanel();
  activeGrid.display();
}

void drawUIPanel() {
  noStroke();
  fill(128);
  rect(0, 0, UI_PANEL_WIDTH, height);
}

/*
CONTROLS
 */

void switchTabs(ControlEvent theControlEvent) {
  String tabName = theControlEvent.getTab().getName();
  println("Clicked " + tabName);

  if (tabName == "default") {
    activeGrid = flairGrid;
  } else if (tabName == "cockpits") {
    activeGrid = cockpitGrid;
  }
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    switchTabs(theControlEvent);
    return;
  }

  String activeTab = activeGrid.sectorType;

  if (activeTab == "flair") { 
    handleFlairEvents(theControlEvent);
  } else if
    (activeTab == "cockpit") { 
    handleCockpitEvents(theControlEvent);
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
  createCockpitUIComponents();
}

// Functions called by controlp5 buttons
public void rebuild(int theValue) {
  activeGrid.rebuild();
}

public void reset(int theValue) {
  if (activeGrid.sectorType == "flair") setFlairRangeValues();
  if (activeGrid.sectorType == "cockpit") setCockpitRangeValues();
  activeGrid.rebuild();
}




/*
FLAIR
 */

void handleFlairEvents(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom(flairWidthRange)) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    flair_minWidth = int(theControlEvent.getController().getArrayValue(0));
    flair_maxWidth = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minWidth, flair_maxWidth: " + flair_minWidth + ", " + flair_maxWidth);
  }

  if (theControlEvent.isFrom(flairHeightRange)) {
    flair_minHeight = int(theControlEvent.getController().getArrayValue(0));
    flair_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minHeight, flair_maxHeight: " + flair_minHeight + ", " + flair_maxHeight);
  }

  if (theControlEvent.isFrom(flairRotationRange)) {
    flair_minRotation = theControlEvent.getController().getArrayValue(0);
    flair_maxRotation = theControlEvent.getController().getArrayValue(1);
    println("flair_minRotation, flair_maxRotation: " + flair_minRotation + ", " + flair_maxRotation);
  }

  if (theControlEvent.isFrom(flairShearRange)) {
    flair_minShear = theControlEvent.getController().getArrayValue(0);
    flair_maxShear = theControlEvent.getController().getArrayValue(1);
    println("flair_minShear, flair_maxShear: " + flair_minShear + ", " + flair_maxShear);
  }


  if (theControlEvent.isFrom(flairRedRange)) {
    flair_minRed = int(theControlEvent.getController().getArrayValue(0));
    flair_maxRed = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minRed, flair_maxRed: " + flair_minRed + ", " + flair_maxRed);
  }

  if (theControlEvent.isFrom(flairGreenRange)) {
    flair_minGreen = int(theControlEvent.getController().getArrayValue(0));
    flair_maxGreen = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minGreen, flair_maxGreen: " + flair_minGreen + ", " + flair_maxGreen);
  }

  if (theControlEvent.isFrom(flairBlueRange)) {
    flair_minBlue = int(theControlEvent.getController().getArrayValue(0));
    flair_maxBlue = int(theControlEvent.getController().getArrayValue(1));
    println("flair_minBlue, flair_maxBlue: " + flair_minBlue + ", " + flair_maxBlue);
  }
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

  flairGreenRange = cp5.addRange("flair green")
    .setBroadcast(false) 
    .setPosition(10, 230)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("default")
    .setBroadcast(true);

  flairBlueRange = cp5.addRange("flair blue")
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





/*
COCKPIT
 */

void handleCockpitEvents(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom(cockpitRedRange)) {
    cockpit_minRed = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxRed = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minRed, cockpit_maxRed: " + cockpit_minRed + ", " + cockpit_maxRed);
  }

  if (theControlEvent.isFrom(cockpitGreenRange)) {
    cockpit_minGreen = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxGreen = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minGreen, cockpit_maxGreen: " + cockpit_minGreen + ", " + cockpit_maxGreen);
  }

  if (theControlEvent.isFrom(cockpitBlueRange)) {
    cockpit_minBlue = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxBlue = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minBlue, cockpit_maxBlue: " + cockpit_minBlue + ", " + cockpit_maxBlue);
  }
  
  if (theControlEvent.isFrom(cockpitWidthRange)) {
    cockpit_minWidth = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxWidth = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minWidth, cockpit_maxWidth: " + cockpit_minWidth + ", " + cockpit_maxWidth);
  }  

  if (theControlEvent.isFrom(cockpitHeightRange)) {
    cockpit_minHeight = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minHeight, cockpit_maxHeight: " + cockpit_minHeight + ", " + cockpit_maxHeight);
  }  

  if (theControlEvent.isFrom(cockpitBaysRange)) {
    cockpit_minBays = int(theControlEvent.getController().getArrayValue(0));
    cockpit_maxBays = int(theControlEvent.getController().getArrayValue(1));
    println("cockpit_minBays, cockpit_maxBays: " + cockpit_minBays + ", " + cockpit_maxBays);
  }  

  if (theControlEvent.isFrom(cockpitCheckbox)) {
    cockpit_type1 = int(cockpitCheckbox.getArrayValue()[0]) == 1 ? true : false;
    cockpit_type2 = int(cockpitCheckbox.getArrayValue()[1]) == 1 ? true : false;
    cockpit_type3 = int(cockpitCheckbox.getArrayValue()[2]) == 1 ? true : false;
    cockpit_window1 = int(cockpitCheckbox.getArrayValue()[3]) == 1 ? true : false;
    cockpit_window2 = int(cockpitCheckbox.getArrayValue()[4]) == 1 ? true : false;
    println("cockpitCheckbox: ");
    println(cockpitCheckbox.getArrayValue());
  }
}

void createCockpitUIComponents() {
  cockpitWidthRange = cp5.addRange("cockpit width")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 30)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(COCKPIT_MIN_WIDTH, COCKPIT_MAX_WIDTH)
    .setRangeValues(COCKPIT_MIN_WIDTH, COCKPIT_MAX_WIDTH)
    .moveTo("cockpits")
    .setBroadcast(true);

  cockpitHeightRange = cp5.addRange("cockpit height")
    .setBroadcast(false) 
    .setPosition(10, 70)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(COCKPIT_MIN_HEIGHT, COCKPIT_MAX_HEIGHT)
    .setRangeValues(COCKPIT_MIN_HEIGHT, COCKPIT_MAX_HEIGHT)
    .moveTo("cockpits")
    .setBroadcast(true);

  cockpitBaysRange = cp5.addRange("cockpit bays")
    .setBroadcast(false) 
    .setPosition(10, 110)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(COCKPIT_MIN_BAYS, COCKPIT_MAX_BAYS)
    .setRangeValues(COCKPIT_MIN_BAYS, COCKPIT_MAX_BAYS)
    .moveTo("cockpits")
    .setBroadcast(true);
    
  cockpitRedRange = cp5.addRange("cockpit red")
    .setBroadcast(false) 
    .setPosition(10, 150)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("cockpits")
    .setBroadcast(true);

  cockpitGreenRange = cp5.addRange("cockpit green")
    .setBroadcast(false) 
    .setPosition(10, 190)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("cockpits")
    .setBroadcast(true);

  cockpitBlueRange = cp5.addRange("cockpit blue")
    .setBroadcast(false) 
    .setPosition(10, 230)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("cockpits")
    .setBroadcast(true);

  cockpitCheckbox = cp5.addCheckBox("cockpit checkBox")
    .setPosition(10, 300)
    .setSize(30, 30)
    .setItemsPerRow(3)
    .setSpacingColumn(50)
    .setSpacingRow(20)
    .addItem("type 1", 1)
    .addItem("type 2", 2)
    .addItem("type 3", 3)
    .addItem("window 1", 4)
    .addItem("window 2", 5)
    .moveTo("cockpits")
    .toggle(0)
    .toggle(1)
    .toggle(2)
    .toggle(3)
    .toggle(4)
    ;
}

void setCockpitRangeValues() {
  cockpit_minWidth = COCKPIT_MIN_WIDTH;
  cockpit_maxWidth = COCKPIT_MAX_WIDTH;
  cockpit_minHeight = COCKPIT_MIN_HEIGHT;
  cockpit_maxHeight = COCKPIT_MAX_HEIGHT;
  cockpit_minBays = COCKPIT_MIN_BAYS;
  cockpit_maxBays = COCKPIT_MAX_BAYS;
  cockpit_window1 = true;
  cockpit_window2 = true;
  cockpit_type1 = true;
  cockpit_type2 = true;
  cockpit_type3 = true;
  cockpit_minRed = MIN_COLOR;
  cockpit_maxRed = MAX_COLOR;
  cockpit_minGreen = MIN_COLOR;
  cockpit_maxGreen = MAX_COLOR;
  cockpit_minBlue = MIN_COLOR;
  cockpit_maxBlue = MAX_COLOR;

  try {
    cockpitWidthRange.setRangeValues(cockpit_minWidth, cockpit_maxWidth);
    cockpitHeightRange.setRangeValues(cockpit_minHeight, cockpit_maxHeight);
    cockpitBaysRange.setRangeValues(cockpit_minBays, cockpit_maxBays);

    cockpit_window1 = true;
    cockpit_window2 = true;
    cockpit_type1 = true;
    cockpit_type2 = true;
    cockpit_type3 = true;
    
    cockpitRedRange.setRangeValues(cockpit_minRed, cockpit_maxRed);
    cockpitGreenRange.setRangeValues(cockpit_minGreen, cockpit_maxGreen);
    cockpitBlueRange.setRangeValues(cockpit_minBlue, cockpit_maxBlue);

    float[] v = {1, 1, 1, 1, 1};
    cockpitCheckbox.setArrayValue(v);
  }
  catch(NullPointerException e) {
  }
  finally {
  }
}
