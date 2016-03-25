PShape usa;
PShape michigan;
PShape ohio;

int xOffset, yOffset;

void setup() {
  size(640, 360);  
  
  xOffset = -350;
  yOffset = -10;
  
  usa = loadShape("Blank_US_Map.svg");
  michigan = usa.getChild("MI");
  ohio = usa.getChild("OH");
}

void draw() {
  background(255);
  
  // Draw the full map
  usa.disableStyle();
  fill(200);
  stroke(255);
  strokeWeight(1);
  shape(usa, xOffset, yOffset);
  
  // Disable the colors found in the SVG file
  michigan.disableStyle();
  // Set our own coloring
  fill(0, 51, 102);
  // Draw a single state
  shape(michigan, xOffset, yOffset); // Wolverines!
  
  // Disable the colors found in the SVG file
  ohio.disableStyle();
  // Set our own coloring
  fill(153, 0, 0);
  // Draw a single state
  shape(ohio, xOffset, yOffset);  // Buckeyes!
}