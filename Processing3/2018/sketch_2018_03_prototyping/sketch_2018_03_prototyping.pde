import java.util.Random;
import controlP5.*;


boolean debug = true;

static int UI_PANEL_WIDTH = 255;
static int GRID_OUTER_MARGIN = 20;
static int GRID_INNER_MARGIN = 20;

static float SCALE_MIN = 0;
static float SCALE_MAX = 1.0;

static float SHEAR_MIN = 0;
static float SHEAR_MAX = 10.0;

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

/*
WINGS
 */
 
static int WINGS_MIN_WIDTH = 20;
static int WINGS_MAX_WIDTH = 150;
static int WINGS_MIN_HEIGHT = 150;
static int WINGS_MAX_HEIGHT = 300;

Range wingsRedRange, wingsGreenRange, wingsBlueRange;
int wings_minRed, wings_maxRed;
int wings_minGreen, wings_maxGreen;
int wings_minBlue, wings_maxBlue;

Range wingsWidthTopRange, wingsWidthBottomRange, wingsHeightRange, wingsShearRange, wingsRotationRange;
int wings_minWidthTop, wings_maxWidthTop;
int wings_minWidthBottom, wings_maxWidthBottom;
int wings_minHeight, wings_maxHeight;
float wings_minShear, wings_maxShear;
float wings_minRotation, wings_maxRotation;

/*
END WINGS
 */
 
 /*
SEGMENTS
 */
 
static int SEGMENTS_MIN_WIDTH = 20;
static int SEGMENTS_MAX_WIDTH = 150;
static int SEGMENTS_MIN_HEIGHT = 150;
static int SEGMENTS_MAX_HEIGHT = 300;
static int SEGMENTS_MIN_CORNER_RADIUS = 0;
static int SEGMENTS_MAX_CORNER_RADIUS = 30;
static int SEGMENTS_MIN_SIDE = 0;
static int SEGMENTS_MAX_SIDE = 4;

Range segmentsRedRange, segmentsGreenRange, segmentsBlueRange;
int segments_minRed, segments_maxRed;
int segments_minGreen, segments_maxGreen;
int segments_minBlue, segments_maxBlue;

Range segmentsWidthRange, segmentsHeightRange;
int segments_minWidth, segments_maxWidth;
int segments_minHeight, segments_maxHeight;

Range segmentsCornerTopRange, segmentsCornerBottomRange;
int segments_minCornerTop, segments_maxCornerTop;
int segments_minCornerBottom, segments_maxCornerBottom;

Range segmentsStripeRedRange, segmentsStripeGreenRange, segmentsStripeBlueRange, segmentsStripeSideRange;
int segments_minStripeRed, segments_maxStripeRed;
int segments_minStripeGreen, segments_maxStripeGreen;
int segments_minStripeBlue, segments_maxStripeBlue;
int segments_minStripeSide, segments_maxStripeSide;
/*
END SEGMENTS
 */
 
 
 
 
 
 

ControlP5 cp5;
Grid activeGrid, flairGrid, cockpitGrid, wingsGrid, segmentsGrid;

void setup() {
  size(1280, 720); 

  setFlairRangeValues();
  setCockpitRangeValues();
  setWingsRangeValues();
  setSegmentsRangeValues();

  // Set up the Grids
  flairGrid = new Grid(5, 3, "flair");
  activeGrid = flairGrid;
  cockpitGrid = new Grid(3, 2, "cockpit");
  wingsGrid = new Grid(3, 1, "wings");
  segmentsGrid = new Grid(4, 4, "segments");

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
  } else if (tabName == "wings") {
    activeGrid = wingsGrid;
  } else if (tabName == "segments") {
    activeGrid = segmentsGrid;
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
  } else if
    (activeTab == "wings") {
    handleWingsEvents(theControlEvent);
  } else if
    (activeTab == "segments") {
    handleSegmentsEvents(theControlEvent);
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
  createWingsUIComponents();
  createSegmentsUIComponents();
}

// Functions called by controlp5 buttons
public void rebuild(int theValue) {
  activeGrid.rebuild();
}

public void reset(int theValue) {
  if (activeGrid.sectorType == "flair") setFlairRangeValues();
  if (activeGrid.sectorType == "cockpit") setCockpitRangeValues();
  if (activeGrid.sectorType == "wings") setWingsRangeValues();
  if (activeGrid.sectorType == "segments") setSegmentsRangeValues();
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




/*
WINGS
 */

void handleWingsEvents(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom(wingsRedRange)) {
    wings_minRed = int(theControlEvent.getController().getArrayValue(0));
    wings_maxRed = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minRed, wings_maxRed: " + wings_minRed + ", " + wings_maxRed);
  }

  if (theControlEvent.isFrom(wingsGreenRange)) {
    wings_minGreen = int(theControlEvent.getController().getArrayValue(0));
    wings_maxGreen = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minGreen, cockpit_maxGreen: " + wings_minGreen + ", " + cockpit_maxGreen);
  }

  if (theControlEvent.isFrom(wingsBlueRange)) {
    wings_minBlue = int(theControlEvent.getController().getArrayValue(0));
    wings_maxBlue = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minBlue, wings_maxBlue: " + wings_minBlue + ", " + wings_maxBlue);
  }

  if (theControlEvent.isFrom(wingsWidthTopRange)) {
    wings_minWidthTop = int(theControlEvent.getController().getArrayValue(0));
    wings_maxWidthTop = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minWidthTop, wings_maxWidthTop: " + wings_minWidthTop + ", " + wings_maxWidthTop);
  }  
  
  if (theControlEvent.isFrom(wingsWidthBottomRange)) {
    wings_minWidthBottom = int(theControlEvent.getController().getArrayValue(0));
    wings_maxWidthBottom = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minWidthBottom, wings_maxWidthBottom: " + wings_minWidthBottom + ", " + wings_maxWidthBottom);
  }  

  if (theControlEvent.isFrom(wingsHeightRange)) {
    wings_minHeight = int(theControlEvent.getController().getArrayValue(0));
    wings_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minHeight, wings_maxHeight: " + wings_minHeight + ", " + wings_maxHeight);
  }  

  if (theControlEvent.isFrom(wingsRotationRange)) {
    wings_minRotation = int(theControlEvent.getController().getArrayValue(0));
    wings_maxRotation = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minRotation, wings_maxRotation: " + wings_minRotation + ", " + wings_maxRotation);
  }  
  
  if (theControlEvent.isFrom(wingsShearRange)) {
    wings_minShear = int(theControlEvent.getController().getArrayValue(0));
    wings_maxShear = int(theControlEvent.getController().getArrayValue(1));
    println("wings_minShear, wings_maxShear: " + wings_minShear + ", " + wings_maxShear);
  }  


}

void createWingsUIComponents() {
  wingsWidthTopRange = cp5.addRange("wing top")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 30)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(WINGS_MIN_WIDTH, WINGS_MAX_WIDTH)
    .setRangeValues(WINGS_MIN_WIDTH, WINGS_MAX_WIDTH)
    .moveTo("wings")
    .setBroadcast(true);
    
  wingsWidthBottomRange = cp5.addRange("wing base")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 70)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(WINGS_MIN_WIDTH, WINGS_MAX_WIDTH)
    .setRangeValues(WINGS_MIN_WIDTH, WINGS_MAX_WIDTH)
    .moveTo("wings")
    .setBroadcast(true);

  wingsHeightRange = cp5.addRange("wing height")
    .setBroadcast(false) 
    .setPosition(10, 110)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(WINGS_MIN_HEIGHT, WINGS_MAX_HEIGHT)
    .setRangeValues(WINGS_MIN_HEIGHT, WINGS_MAX_HEIGHT)
    .moveTo("wings")
    .setBroadcast(true);
    
  wingsRotationRange = cp5.addRange("wing rotation")
    .setBroadcast(false) 
    .setPosition(10, 150)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(ROTATION_MIN, ROTATION_MAX)
    .setRangeValues(ROTATION_MIN, ROTATION_MIN)
    .moveTo("wings")
    .setBroadcast(true);

  wingsShearRange = cp5.addRange("wing shear")
    .setBroadcast(false) 
    .setPosition(10, 190)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SHEAR_MIN, SHEAR_MAX)
    .setRangeValues(SHEAR_MIN, SHEAR_MIN)
    .moveTo("wings")
    .setBroadcast(true);
    
  // colors
  wingsRedRange = cp5.addRange("wing red")
    .setBroadcast(false) 
    .setPosition(10, 230)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("wings")
    .setBroadcast(true);

  wingsGreenRange = cp5.addRange("wing green")
    .setBroadcast(false) 
    .setPosition(10, 270)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("wings")
    .setBroadcast(true);

  wingsBlueRange = cp5.addRange("wing blue")
    .setBroadcast(false) 
    .setPosition(10, 310)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("wings")
    .setBroadcast(true);
}

void setWingsRangeValues() {
  wings_minWidthTop = WINGS_MIN_WIDTH;
  wings_maxWidthTop = WINGS_MAX_WIDTH;
  wings_minWidthBottom = WINGS_MIN_WIDTH;
  wings_maxWidthBottom = WINGS_MAX_WIDTH;
  wings_minHeight = WINGS_MIN_HEIGHT;
  wings_maxHeight = WINGS_MAX_HEIGHT;
  wings_minRotation = ROTATION_MIN;
  wings_maxRotation = ROTATION_MIN;
  wings_minShear = SHEAR_MIN;
  wings_maxShear = SHEAR_MIN;

  wings_minRed = MIN_COLOR;
  wings_maxRed = MAX_COLOR;
  wings_minGreen = MIN_COLOR;
  wings_maxGreen = MAX_COLOR;
  wings_minBlue = MIN_COLOR;
  wings_maxBlue = MAX_COLOR;

  try {
    wingsWidthTopRange.setRangeValues(wings_minWidthTop, wings_maxWidthTop);
    wingsWidthBottomRange.setRangeValues(wings_minWidthBottom, wings_maxWidthBottom);
    wingsHeightRange.setRangeValues(wings_minHeight, wings_maxHeight);
    wingsShearRange.setRangeValues(wings_minShear, wings_maxShear);
    wingsRotationRange.setRangeValues(wings_minRotation, wings_maxRotation);

    wingsRedRange.setRangeValues(wings_minRed, wings_maxRed);
    wingsGreenRange.setRangeValues(wings_minGreen, wings_maxGreen);
    wingsBlueRange.setRangeValues(wings_minBlue, wings_maxBlue);
  }
  catch(NullPointerException e) {
  }
  finally {
  }
}








/*
SEGMENTS
 */

void handleSegmentsEvents(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom(segmentsRedRange)) {
    segments_minRed = int(theControlEvent.getController().getArrayValue(0));
    segments_maxRed = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minRed, segments_maxRed: " + segments_minRed + ", " + segments_maxRed);
  }

  if (theControlEvent.isFrom(segmentsGreenRange)) {
    segments_minGreen = int(theControlEvent.getController().getArrayValue(0));
    segments_maxGreen = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minGreen, segments_maxGreen: " + segments_minGreen + ", " + segments_maxGreen);
  }

  if (theControlEvent.isFrom(segmentsBlueRange)) {
    segments_minBlue = int(theControlEvent.getController().getArrayValue(0));
    segments_maxBlue = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minBlue, segments_maxBlue: " + segments_minBlue + ", " + segments_maxBlue);
  }

  if (theControlEvent.isFrom(segmentsCornerBottomRange)) {
    segments_minCornerBottom = int(theControlEvent.getController().getArrayValue(0));
    segments_maxCornerBottom = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minCornerBottom, segments_maxCornerBottom: " + segments_minCornerBottom + ", " + segments_maxCornerBottom);
  }  
  
  if (theControlEvent.isFrom(segmentsCornerTopRange)) {
    segments_minCornerTop = int(theControlEvent.getController().getArrayValue(0));
    segments_maxCornerTop = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minCornerTop, segments_maxCornerTop: " + segments_minCornerTop + ", " + segments_maxCornerTop);
  }  
  
  if (theControlEvent.isFrom(segmentsWidthRange)) {
    segments_minHeight = int(theControlEvent.getController().getArrayValue(0));
    segments_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minHeight, segments_maxHeight: " + segments_minHeight + ", " + segments_maxHeight);
  }  

  if (theControlEvent.isFrom(segmentsHeightRange)) {
    segments_minHeight = int(theControlEvent.getController().getArrayValue(0));
    segments_maxHeight = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minHeight, segments_maxHeight: " + segments_minHeight + ", " + segments_maxHeight);
  }  



  // Segment Stripes
  if (theControlEvent.isFrom(segmentsStripeRedRange)) {
    segments_minStripeRed = int(theControlEvent.getController().getArrayValue(0));
    segments_maxStripeRed = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minStripeRed, segments_maxStripeRed: " + segments_minStripeRed + ", " + segments_maxStripeRed);
  }

  if (theControlEvent.isFrom(segmentsStripeGreenRange)) {
    segments_minStripeGreen = int(theControlEvent.getController().getArrayValue(0));
    segments_maxStripeGreen = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minStripeGreen, segments_maxStripeGreen: " + segments_minStripeGreen + ", " + segments_maxStripeGreen);
  }

  if (theControlEvent.isFrom(segmentsStripeBlueRange)) {
    segments_minStripeBlue = int(theControlEvent.getController().getArrayValue(0));
    segments_maxStripeBlue = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minStripeBlue, segments_maxStripeBlue: " + segments_minStripeBlue + ", " + segments_maxStripeBlue);
  }
  
  if (theControlEvent.isFrom(segmentsStripeSideRange)) {
    segments_minStripeSide = int(theControlEvent.getController().getArrayValue(0));
    segments_maxStripeSide = int(theControlEvent.getController().getArrayValue(1));
    println("segments_minStripeSide, segments_maxStripeSide: " + segments_minStripeSide + ", " + segments_maxStripeSide);
  }

}

// TODO: Set positions of controls and create constants
void createSegmentsUIComponents() {
  segmentsCornerBottomRange = cp5.addRange("top corners")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 30)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SEGMENTS_MIN_CORNER_RADIUS, SEGMENTS_MAX_CORNER_RADIUS) // CHANGE?
    .setRangeValues(SEGMENTS_MIN_CORNER_RADIUS, SEGMENTS_MAX_CORNER_RADIUS)
    .moveTo("segments")
    .setBroadcast(true);
    
  segmentsCornerTopRange = cp5.addRange("bot. corners")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 70)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SEGMENTS_MIN_CORNER_RADIUS, SEGMENTS_MAX_CORNER_RADIUS)
    .setRangeValues(SEGMENTS_MIN_CORNER_RADIUS, SEGMENTS_MAX_CORNER_RADIUS)
    .moveTo("segments")
    .setBroadcast(true);

  segmentsHeightRange = cp5.addRange("seg. height")
    .setBroadcast(false) 
    .setPosition(10, 110)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SEGMENTS_MIN_HEIGHT, SEGMENTS_MAX_HEIGHT)
    .setRangeValues(SEGMENTS_MIN_HEIGHT, SEGMENTS_MAX_HEIGHT)
    .moveTo("segments")
    .setBroadcast(true);
    
   segmentsWidthRange = cp5.addRange("seg. width")
    .setBroadcast(false) 
    .setPosition(10, 150)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SEGMENTS_MIN_WIDTH, SEGMENTS_MAX_WIDTH)
    .setRangeValues(SEGMENTS_MIN_WIDTH, SEGMENTS_MAX_WIDTH)
    .moveTo("segments")
    .setBroadcast(true);
    
  // colors
  segmentsRedRange = cp5.addRange("seg. red")
    .setBroadcast(false) 
    .setPosition(10, 230)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);

  segmentsGreenRange = cp5.addRange("seg. green")
    .setBroadcast(false) 
    .setPosition(10, 270)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);

  segmentsBlueRange = cp5.addRange("seg. blue")
    .setBroadcast(false) 
    .setPosition(10, 310)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);
    
    
    // Stripe Colors
  segmentsStripeRedRange = cp5.addRange("stripe red")
    .setBroadcast(false) 
    .setPosition(10, 390)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);

  segmentsStripeGreenRange = cp5.addRange("stripe green")
    .setBroadcast(false) 
    .setPosition(10, 430)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);

  segmentsStripeBlueRange = cp5.addRange("stripe blue")
    .setBroadcast(false) 
    .setPosition(10, 470)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(MIN_COLOR, MAX_COLOR)
    .setRangeValues(MIN_COLOR, MAX_COLOR)
    .moveTo("segments")
    .setBroadcast(true);
    
  segmentsStripeSideRange = cp5.addRange("stripe side")
    .setBroadcast(false) 
    .setPosition(10, 510)
    .setSize(180, 30)
    .setHandleSize(20)
    .setRange(SEGMENTS_MIN_SIDE, SEGMENTS_MAX_SIDE)
    .setRangeValues(SEGMENTS_MIN_SIDE, SEGMENTS_MAX_SIDE)
    .moveTo("segments")
    .setBroadcast(true);
}

void setSegmentsRangeValues() {
  segments_minWidth = SEGMENTS_MIN_WIDTH;
  segments_maxWidth = SEGMENTS_MAX_WIDTH;
  segments_minHeight = WINGS_MIN_HEIGHT;
  segments_maxHeight = WINGS_MAX_HEIGHT;
  
  segments_minCornerBottom = WINGS_MIN_WIDTH;
  segments_maxCornerBottom = WINGS_MAX_WIDTH;

  segments_minRed = MIN_COLOR;
  segments_maxRed = MAX_COLOR;
  segments_minGreen = MIN_COLOR;
  segments_maxGreen = MAX_COLOR;
  segments_minBlue = MIN_COLOR;
  segments_maxBlue = MAX_COLOR;
  
  segments_minStripeRed = MIN_COLOR;
  segments_maxStripeRed = MAX_COLOR;
  segments_minStripeGreen = MIN_COLOR;
  segments_maxStripeGreen = MAX_COLOR;
  segments_minStripeBlue = MIN_COLOR;
  segments_maxStripeBlue = MAX_COLOR;
  
  segments_minStripeSide = SEGMENTS_MIN_SIDE;
  segments_maxStripeSide = SEGMENTS_MAX_SIDE;

  try {
    segmentsWidthRange.setRangeValues(segments_minWidth, segments_maxWidth);
    segmentsHeightRange.setRangeValues(segments_minHeight, segments_maxHeight);
    
    segmentsCornerTopRange.setRangeValues(segments_minCornerTop, segments_maxCornerTop);
    segmentsCornerBottomRange.setRangeValues(segments_minCornerBottom, segments_maxCornerBottom);

    segmentsRedRange.setRangeValues(segments_minRed, segments_maxRed);
    segmentsGreenRange.setRangeValues(segments_minGreen, segments_maxGreen);
    segmentsBlueRange.setRangeValues(segments_minBlue, segments_maxBlue);
    
    segmentsStripeRedRange.setRangeValues(segments_minStripeRed, segments_maxStripeRed);
    segmentsStripeGreenRange.setRangeValues(segments_minStripeGreen, segments_maxStripeGreen);
    segmentsStripeBlueRange.setRangeValues(segments_minStripeBlue, segments_maxStripeBlue);
  }
  catch(NullPointerException e) {
  }
  finally {
  }
}
