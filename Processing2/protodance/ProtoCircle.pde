/* A proto circle is a shape that is like a circle with an additional rippled edge.
 The rippled edge is between the values of 1 and 2. Scale them to draw.
 This is a terrible explanation.
 */
class ProtoCircle {
  int numPoints;
  float angle_delta;
  ArrayList<PVector>points;

  ProtoCircle(int _numPoints) {
    numPoints = _numPoints;
    angle_delta = radians(360.0/(numPoints));
    points = new ArrayList<PVector>();
    establishPoints();
  }

  void establishPoints() {
    // Start at 0 degrees
    float angle = 0.0;
    float d = random(1) + 1;
    PVector p = pointOnCircle(0, 0, d, 0);
    points.add(p);

    for (int i = 0; i < numPoints-1; i++) {
      angle += angle_delta;
      d = random(1) + 1;
      PVector pt = pointOnCircle(0, 0, d, angle);
      points.add(pt);
    }
  }  

  PVector pointOnCircle(float _cx, float _cy, float _diameter, float _angle) {
    float x = _cx + _diameter/2.0 * sin(_angle);
    float y = _cy + _diameter/2.0 * cos(_angle);
    PVector thePoint = new PVector(x, y);
    return thePoint;
  }

  void display() {
    //noStroke();
    //strokeWeight(0.02);
    //stroke(255);
    PVector startEnd = points.get(0);
    beginShape(); 
    curveVertex(startEnd.x, startEnd.y);
    curveVertex(startEnd.x, startEnd.y);
    for (int i = 1; i < points.size (); i++) {
      PVector p = points.get(i);
      curveVertex(p.x, p.y);
    }
    curveVertex(startEnd.x, startEnd.y);
    curveVertex(startEnd.x, startEnd.y);
    endShape(CLOSE);
  }

  void debugDisplay() {
    for (int i = 0; i < points.size (); i++) {
      fill(255, 0, 0);
      noStroke();
      PVector p = points.get(i);
      ellipse(p.x, p.y, 5, 5);
    }

    stroke(0, 0, 255);
    noFill();
    strokeWeight(1);
    ellipse(0, 0, 100, 100);
    ellipse(0, 0, 200, 200);
  }
}

