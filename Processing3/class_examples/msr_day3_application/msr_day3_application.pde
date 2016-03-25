int r, g, b, a, brushSize, mode;

void setup() {
  size(1000, 550);
  background(255);

  // Default values for colors
  r = 0;
  g = 0;
  b = 0;
  a = 255;
  brushSize = 20;
  mode = 0;
}

void draw() {
  drawColorBox();

  fill(r, g, b, a);
  noStroke();
  if (mousePressed) {
    ellipse(mouseX, mouseY, brushSize, brushSize);

    if (mode == 1) {
      ellipse(width - mouseX, mouseY, brushSize, brushSize);
    } else if (mode == 2) {
      ellipse(mouseX, height - mouseY, brushSize, brushSize); 
    } else if (mode == 3) {
      ellipse(width - mouseX, mouseY,          brushSize, brushSize);
      ellipse(mouseX,         height - mouseY, brushSize, brushSize);
      ellipse(width - mouseX, height - mouseY, brushSize, brushSize);
    }
    
  }
}


void drawColorBox() {
  // Fill color for color box
  fill(r, g, b, 255);
  noStroke();
  rect(0, 0, 250, 20);

  // Fill color for text
  fill(255-r, 255-g, 255-b, 255);
  textAlign(LEFT, TOP);
  text("r:" + r + " g:" + g + " b:" + b + " a:" + a + " brush:" + brushSize + " mode:" + mode, 0, 0);
}

void keyPressed() {
  if (key == 'm') {
    mode += 1;
    if (mode > 3) {
      mode = 0;
    }
  }

  if (key == '.') {
    brushSize += 1;
  }

  if (key == ',') {
    brushSize -= 1;
    if (brushSize < 1) {
      brushSize = 1;
    }
  }

  // Change the red channel value
  if (key == 'r') {
    r += 10;
    if (r > 255) {
      r = 0;
    }
  }

  // Change the green channel value
  if (key == 'g') {
    g += 10;
    if (g > 255) {
      g = 0;
    }
  }

  // Change the blue channel value
  if (key == 'b') {
    b += 10;
    if (b > 255) {
      b = 0;
    }
  }

  // Change the alpha channel value
  if (key == 'a') {
    a += 5;
    if (a > 255) {
      a = 0;
    }
  }
}