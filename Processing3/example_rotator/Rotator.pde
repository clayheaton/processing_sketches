class Rotator {
  int num_arcs;
  PVector rotCenter;
  float baselineAngle = radians(90);
  float baselineAngleDelta;
  float innerDiameter;
  int loopNumber;
  float rotStrokeWeight;
  boolean includeGap;
  float diameterMod;
  
  Rotator(int _num_arcs, float _innerDiameter,float _strokeWeight, boolean _includeGap) {
    this.num_arcs        = _num_arcs;
    this.innerDiameter   = _innerDiameter;
    this.rotStrokeWeight = _strokeWeight;
    
    if(_includeGap){
      this.diameterMod = 2.5;
    } else {
      this.diameterMod = 1.5;
    }
    
    baselineAngleDelta   = random(0.01,0.02);
  }

  void displayAt(int _x, int _y) {
    pushMatrix();
    translate(_x,_y);
    strokeWeight(this.rotStrokeWeight);
    
    for(int i = 0; i < this.num_arcs; i++){
      float thisAngleDelta = baselineAngle - ( i * baselineAngleDelta);
      float size           = this.innerDiameter + (this.rotStrokeWeight * this.diameterMod * i);
      float startAngle     = radians(-180 + (i * thisAngleDelta));
      float stopAngle      = radians(i * thisAngleDelta);
      
      arc(0,0,size,size,startAngle,stopAngle);
    }
    
    baselineAngle -= 1;
    popMatrix();
  }
}