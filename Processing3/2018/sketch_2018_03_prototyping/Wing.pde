class Wing {
  int wTop, wBottom, h, r, g, b;
  float shear, rotation;
  color fill_color, outline_color;
  PVector upperLeft, upperRight, lowerRight, lowerLeft;
  PVector midBottom, midTop, midPoint, lowerThird, upperThird;
  Flair flair;
  Wing() {
    this.wTop = (int)random(wings_minWidthTop, wings_maxWidthTop);
    this.wBottom = (int)random(wings_minWidthBottom, wings_maxWidthBottom);
    this.h = (int)random(wings_minHeight, wings_maxHeight);
    this.r = (int)random(wings_minRed, wings_maxRed);
    this.g = (int)random(wings_minGreen, wings_maxGreen);
    this.b = (int)random(wings_minBlue, wings_maxBlue);
    this.shear = random(wings_minShear, wings_maxShear);
    this.rotation = random(wings_minRotation, wings_maxRotation);

    fill_color = color(this.r, this.g, this.b);
    color c = color(0);
    outline_color = lerpColor(fill_color, c, 0.33);

    float offsetTop = this.shear * this.wTop / 2;

    upperLeft = new PVector(0 - this.wTop/2 + offsetTop, 0 - this.h/2);
    upperRight = new PVector(this.wTop/2 + offsetTop, 0 - this.h/2);
    lowerRight = new PVector(this.wBottom/2, this.h/2);
    lowerLeft = new PVector(0 - this.wBottom/2, this.h/2);

    midBottom = PVector.lerp(lowerLeft, lowerRight, 0.5);
    midTop = PVector.lerp(upperLeft, upperRight, 0.5);
    midPoint = PVector.lerp(midBottom, midTop, 0.5);
    lowerThird = PVector.lerp(midBottom, midTop, 0.25);
    upperThird = PVector.lerp(midBottom, midTop, 0.75);

    flair = new Flair();
  }

  void display() {
    fill(fill_color);
    stroke(outline_color);

    pushMatrix();
    rotate(this.rotation);
    beginShape();
    vertex(upperLeft.x, upperLeft.y);
    vertex(upperRight.x, upperRight.y);
    vertex(lowerRight.x, lowerRight.y);
    vertex(lowerLeft.x, lowerLeft.y);
    endShape(CLOSE);

    pushMatrix();
    translate(midPoint.x, midPoint.y);
    flair.display();
    popMatrix();
    
    pushMatrix();
    translate(lowerThird.x, lowerThird.y);
    flair.display();
    popMatrix();
    
    pushMatrix();
    translate(upperThird.x, upperThird.y);
    flair.display();
    popMatrix();

    popMatrix();
  }
}
