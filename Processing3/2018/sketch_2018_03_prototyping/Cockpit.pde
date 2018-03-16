class Cockpit {
  int w, h, r, g, b, bays;
  float window_diam;
  String cockpit_type, cockpit_window_style;
  color fillcolor, outlinecolor;
  Cockpit() {
    this.w = (int)random(cockpit_minWidth, cockpit_maxWidth);
    this.h = (int)random(cockpit_minHeight, cockpit_maxHeight);
    this.r = (int)random(cockpit_minRed, cockpit_maxRed);
    this.g = (int)random(cockpit_minGreen, cockpit_maxGreen);
    this.b = (int)random(cockpit_minBlue, cockpit_maxBlue);
    this.bays = (int)random(cockpit_minBays, cockpit_maxBays+0.99); // bump because otherwise we never see 4
    this.fillcolor = color(this.r, this.g, this.b);
    color black = color(0);
    this.outlinecolor = lerpColor(this.fillcolor, black, 0.33);

    if (this.bays == 0) {
      this.window_diam = 0;
    } else {
      if (this.w > this.h){
        this.window_diam = (this.h / this.bays) * 0.7;
      } else {
        this.window_diam = (this.w / this.bays) * 0.7;
      }
    }

    ArrayList<String> types = new ArrayList<String>();
    if (cockpit_type1) types.add("type1");
    if (cockpit_type2) types.add("type2");
    if (cockpit_type3) types.add("type3");

    // Must always have one type
    if (types.size() == 0) types.add("type1");

    // Pick a random type from the list
    cockpit_type = types.get(new Random().nextInt(types.size()));

    ArrayList<String> windows = new ArrayList<String>();
    if (cockpit_window1) windows.add("window1");
    if (cockpit_window2) windows.add("window2");

    if (windows.size() == 0) windows.add("window1");

    cockpit_window_style = windows.get(new Random().nextInt(windows.size()));
  }

  void display() {
    ellipseMode(CENTER);
    rectMode(CENTER);
    if (cockpit_type == "type1") { 
      drawType1();
    } else if (cockpit_type == "type2") { 
      drawType2();
    } else if (cockpit_type == "type3") { 
      drawType3();
    }
    rectMode(CORNER);
  }

  void drawType1() {
    noStroke();
    fill(220, 220, 255);
    float radius = this.window_diam/2;

    // Square with a circle coming out the front
    for (int i = 0; i < this.bays; i++) {
      float yCenter = (this.bays * radius) - radius - (i*this.window_diam);
      if (cockpit_window_style == "window1") {
        ellipse(-this.w/2, yCenter, this.window_diam, this.window_diam*1.2);
      } else {
        // Square windows
        rect(-this.w/2, yCenter, this.window_diam*0.9, this.window_diam*0.9);
      }
    }


    // hull
    rectMode(CORNER);
    stroke(this.outlinecolor);
    strokeWeight(1);
    fill(this.fillcolor);
    rect(-this.w/2, -this.h/2, this.w, this.h);
  }

  void drawType2() {
    // Elongated arc
    noStroke();
    fill(220, 220, 255);
    float radius = this.window_diam/2;

    for (int i = 0; i < this.bays; i++) {
      float yCenter = (this.bays * radius) - radius - (i*this.window_diam);
      if (cockpit_window_style == "window1") {
        ellipse(-this.w/2, yCenter, this.window_diam, this.window_diam);
      } else {
        // Square windows
        rect(-this.w/2, yCenter, this.window_diam*0.9, this.window_diam*0.9);
      }
    }


    stroke(this.outlinecolor);
    strokeWeight(1);
    fill(this.fillcolor);
    arc(0, 0, this.w, this.h, HALF_PI, 3*PI/2, CHORD);
  }

  void drawType3() {
    // Triangle
    noStroke();
    fill(220, 220, 255);
    ArrayList<PVector> points = new ArrayList<PVector>();

    PVector tip = new PVector(-this.w/2, 0);
    PVector top = new PVector(this.w/2, -this.h/2);
    PVector bottom = new PVector(this.w/2, this.h/2);

    points.add(PVector.lerp(tip, top, 0.33));
    points.add(PVector.lerp(tip, top, 0.66));
    points.add(PVector.lerp(tip, bottom, 0.33));
    points.add(PVector.lerp(tip, bottom, 0.66));

    if (this.bays > 0) {
      if (this.w > this.h) {
        this.window_diam = (this.h / max(1.4,this.bays)) * 0.7;
      } else {
        this.window_diam = (this.w / max(1.4,this.bays)) * 0.7;
      }
      
    }

    for (int i = 0; i < this.bays; i++) {
      PVector pt = points.get(i);
      if (cockpit_window_style == "window1") {
        ellipse(pt.x, pt.y, this.window_diam, this.window_diam);
      } else {
        // Square windows
        rect(pt.x, pt.y, this.window_diam, this.window_diam);
      }
    }

    stroke(this.outlinecolor);
    strokeWeight(1);
    fill(this.fillcolor);
    triangle(-this.w/2, 0, this.w/2, -this.h/2, this.w/2, this.h/2);
  }
}
