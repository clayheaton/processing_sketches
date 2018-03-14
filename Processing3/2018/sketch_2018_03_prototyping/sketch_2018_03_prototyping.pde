import controlP5.*;

boolean debug = true;

static int UI_PANEL_WIDTH = 255;
static int GRID_OUTER_MARGIN = 20;
static int GRID_INNER_MARGIN = 20;

static float SCALE_MIN = 0;
static float SCALE_MAX = 1.0;

static int MIN_COLOR = 0;
static int MAX_COLOR = 255;

static int FLAIR_MIN_DIM = 1;
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

float flair_shearScaleMin = FLAIR_SHEAR_MIN;
float flair_shearScaleMax = FLAIR_SHEAR_MAX;

ControlP5 cp5;
Grid flairGrid;

void setup() {
  size(1280, 720); 

  cp5 = new ControlP5(this);
  cp5.getTab("default").activateEvent(true).setLabel("flair").setId(1);
  cp5.addTab("cockpits").activateEvent(true).setId(2);
  cp5.addTab("wings").activateEvent(true).setId(3);
  cp5.addTab("segments").activateEvent(true).setId(4);
  cp5.addTab("tails").activateEvent(true).setId(5);
  cp5.addTab("ships").activateEvent(true).setId(6);
  cp5.addTab("armadas").activateEvent(true).setId(7);

  // Set up the Grids
  flairGrid = new Grid(5, 3, "flair");

  background(255);
}


void draw() {
  background(255);
  drawUIPanel();
  flairGrid.display();
}

void drawUIPanel() {
  noStroke();
  fill(240);
  rect(0, 0, UI_PANEL_WIDTH, height);
}