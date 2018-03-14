class Flair {
  int w, h, r, g, b;
  float shear;
  PVector upperLeft, upperRight, lowerRight, lowerLeft;
  
  Flair() {
    this.w = (int)random(flair_minWidth, flair_maxWidth);
    this.h = (int)random(flair_minHeight, flair_maxHeight);
    this.r = (int)random(flair_minRed, flair_maxRed);
    this.g = (int)random(flair_minGreen, flair_maxGreen);
    this.b = (int)random(flair_minBlue, flair_maxBlue);
    this.shear = random(flair_minShear, flair_maxShear);
    
    float offset = this.shear * this.w / 2;
    
    upperLeft = new PVector(0 - this.w/2 + offset, 0 - this.h/2);
    upperRight = new PVector(this.w/2 + offset, 0 - this.h/2);
    lowerRight = new PVector(this.w/2, this.h/2);
    lowerLeft = new PVector(0 - this.w/2, this.h/2);
  }
  
  void display(){
    fill(this.r, this.g, this.b);
    noStroke();
    beginShape();
    vertex(upperLeft.x, upperLeft.y);
    vertex(upperRight.x, upperRight.y);
    vertex(lowerRight.x, lowerRight.y);
    vertex(lowerLeft.x, lowerLeft.y);
    endShape(CLOSE);
  }
}