float noiseScale = 0.004;
int x = 0;
int y = 0;
float x_offset, y_offset;

PFont f;
int fontsize = 14;

void setup() {
  size(800, 800);
  background(255);
  f = createFont("Cambria-Bold",fontsize);
  textFont(f);
  textAlign(CENTER,CENTER);
  x_offset = 0;
  y_offset = 0;
}

void draw() {
  background(255);
  float x_change, y_change;
  
  x_change = map(mouseX,0,width,10,-10);
  y_change = map(mouseY,0,height,10,-10);
  
  x_offset += x_change;
  y_offset += y_change;
  
  for (int x = 0; x < width; x += fontsize) {
    for (int y = 0; y < height; y += fontsize) {
      // We know that n is between 0 and 1
      float n = noise((x+x_offset)*noiseScale, (y+y_offset)*noiseScale);

      // We know that the uppercase letters are
      // between 65 and 90 in char codes.
      int letterOffset = (int)(n * (90-65));
    
      // Use char() to convert code to letter
      char letter = char(65 + letterOffset);
      
      // Change the color based on the offset
      float redChannel = map(letterOffset,0,25,0,255);
      float alphaChannel = map(redChannel,0,150,0,255);
      fill(redChannel,50,50,alphaChannel);
      
      // Let's rotate based on how close we are to 255 for red
      float rotationAngle = map(redChannel,0,255,0,360);
      rotationAngle = radians(rotationAngle);
      
      pushMatrix();
      translate(x,y);
      rotate(rotationAngle);
      text(letter,0,0);
      popMatrix();
    }
  }
  //noLoop();
}