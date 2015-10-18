boolean debug   = true;

// For loading in the game
String gamefile = "default.json"; // Replace with different specs
JSONObject json;

// Establish the color library
ColorLibrary color_library;

// Handling layers
LayerHandler layerHandler = new LayerHandler();

void setup() {
  size(1300, 800); 

  // Load the gamefile
  json = loadJSONObject("default.json");

  JSONArray color_array = json.getJSONArray("colors");
  color_library = new ColorLibrary(color_array);

  JSONObject backgroundData = json.getJSONObject("backgroundLayer");
  layerHandler.createBackgroundLayerWith(backgroundData);

  smooth();

  // Start with a black background
  background(0);

  // For Debugging
  // if (debug) printArray(PFont.list());
}

void draw() {
  layerHandler.displayLayers();
  noLoop();
}