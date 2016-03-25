class Rotator {
  int num_arcs;
  PVector rotCenter;
  float baselineAngle = 0;
  float baselineAngleDelta;
  float innerDiameter;
  int loopNumber;
  float rotStrokeWeight;
  boolean includeGap;
  float diameterMod;
  int[] colors;

  Rotator(int _num_arcs, float _innerDiameter, float _strokeWeight, boolean _includeGap, boolean _randomAngle) {
    this.num_arcs        = _num_arcs;
    this.innerDiameter   = _innerDiameter;
    this.rotStrokeWeight = _strokeWeight;

    if (_includeGap) {
      this.diameterMod = 2.5;
    } else {
      this.diameterMod = 1.5;
    }

    colors = new int[_num_arcs];

    for (int i = 0; i < _num_arcs; i++) {
      color c = color(random(255), random(255), random(255));
      colors[i] = c;
    }
    
    if (_randomAngle){
     baselineAngle = (int)random(360); 
    }

    baselineAngleDelta   = random(0.01, 0.02);
  }

  void displayAt(float _x, float _y) {
    pushMatrix();
    translate(_x, _y);
    stroke(0);

    strokeWeight(this.rotStrokeWeight);
    noFill();
    for (int i = 0; i < this.num_arcs; i++) {
      float thisAngleDelta = baselineAngle - ( i * baselineAngleDelta);
      float size           = this.innerDiameter + (this.rotStrokeWeight * this.diameterMod * i);
      float startAngle     = radians(-180 + (i * thisAngleDelta));
      float stopAngle      = radians(i * thisAngleDelta);

      stroke(colors[i]);
      arc(0, 0, size, size, startAngle, stopAngle);
    }

    baselineAngle -= 1;
    popMatrix();
  }
}