class FungusLeaf {
  int x, y;
  float startAngle, endAngle, radius, angleJitter;
  ArrayList<PVector> points;

  FungusLeaf(int _x, int _y, float _angle, float _radius) {
    x           = _x;
    y           = _y;
    startAngle  = _angle - random(PI / 6, PI / 2);
    endAngle    = _angle + random(PI / 6, PI / 2);
    radius      = _radius;
    points      = new ArrayList<PVector>();
    angleJitter = 0.1;
    setupPoints();
  }

  void setupPoints() {
    // First point is close to the x,y center
    PVector first = pointOnPath(startAngle + random(-angleJitter,angleJitter), radius*0.25, random(0.9, 1.1));
    points.add(first);

    PVector second = pointOnPath(startAngle + random(-angleJitter,angleJitter), radius*0.5, random(0.9, 1.1));
    points.add(second);

    PVector third = pointOnPath(startAngle + random(-angleJitter,angleJitter), radius*0.75, random(0.9, 1.1));
    points.add(third);

    PVector fourth = pointOnPath(startAngle + random(-angleJitter,angleJitter), radius, random(0.9, 1.1));
    points.add(fourth);

    for (int i = 1; i < 15; i++) {
      PVector pt = pointOnPath(lerp(startAngle, endAngle, float(i)/20), radius*random(0.9, 1.1), random(0.98, 1.02));
      points.add(pt);
    }

    PVector fourth_l = pointOnPath(endAngle + random(-angleJitter,angleJitter), radius, random(0.9, 1.1));
    points.add(fourth_l);

    PVector third_l = pointOnPath(endAngle + random(-angleJitter,angleJitter), radius*0.75, random(0.9, 1.1));
    points.add(third_l);

    PVector second_l = pointOnPath(endAngle + random(-angleJitter,angleJitter), radius*0.5, random(0.9, 1.1));
    points.add(second_l);

    PVector first_l = pointOnPath(endAngle + random(-angleJitter,angleJitter), radius*0.25, random(0.9, 1.1));
    points.add(first_l);
  }

  PVector pointOnPath(float _angle, float _radius, float _radiusVariance) {
    float xPt  = this.x + sin(_angle)*_radius*_radiusVariance; 
    float yPt  = this.y + cos(_angle)*_radius*_radiusVariance; 
    PVector pv = new PVector(xPt, yPt);
    return pv;
  }

  void display() {
    noFill();
    
    PVector center = new PVector(this.x,this.y);
    noStroke();
    for(int i = 0; i < colors.length; i++){
      float dist = min(1.0, 1.0 - (float)i / colors.length);
      println(dist);
      fill(colors[i]);
      beginShape();
      PVector st_pt = points.get(0);
      PVector st_pt_n = PVector.lerp(center,st_pt,dist);
      curveVertex(st_pt_n.x,st_pt_n.y);
      for(PVector p : points){
        PVector n_p = PVector.lerp(center,p,dist);
        curveVertex(n_p.x,n_p.y);
      }
      PVector lp = points.get(points.size() - 1);
      PVector lp_n = PVector.lerp(center,lp,dist);
      curveVertex(lp_n.x,lp_n.y);
      endShape();
    }
  }
}