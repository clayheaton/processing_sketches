class House {
  
  House() {
  }
  
  void displayAt(int _x, int _y, float _scale, float _rot){
    strokeWeight(1);
    stroke(0);
    fill(255,0,0);
    
    pushMatrix();
    translate(_x,_y);
    rotate(radians(_rot));
    scale(_scale);
    rect(0,-100,100,100);
    fill(0,0,255);
    triangle(0,-100,100,-100,50,-150);
    popMatrix();
  }
}