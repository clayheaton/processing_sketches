PImage anse;
PFont f;

float noiseScale = 0.005;

void setup() {
  size(640, 400);
  anse = loadImage("anse.jpg");
  background(0);
  f = createFont("Arial-Black", 12);
  textFont(f);
  textAlign(CENTER, CENTER);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  for (int i = 0; i < 10000; i++) {
    int randomX = (int)random(anse.width);
    int randomY = (int)random(anse.height);
    
    // Get the color of a pixel and set it as the fill
    color c = anse.get(randomX, randomY);
    fill(c);

    // Huge ranges from 0-360
    float rotAngle = hue(c);

    float n = noise(randomX*noiseScale, randomY*noiseScale);

    // We know that the uppercase letters are
    // between 65 and 90 in char codes.
    int letterOffset = (int)(n * (90-65));

    // Use char() to convert code to letter
    char letter = char(65 + letterOffset);
    
    pushMatrix();
    translate(randomX,randomY);
    rotate(rotAngle);
    text(letter,0,0);
    popMatrix();
    
  }
  noLoop();
}