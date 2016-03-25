class WaveCircle {
  int resolution, num_waves;
  float radius, wave_height, wave_pct, counter;
  float stroke_weight, counter_increment, angle_offset;
  color c;
  boolean sine, useCurves;

  ArrayList<PVector> pts; // Don't need to initialize b/c update overwrites it.

  WaveCircle(int _res, int _nWaves, float _r, float _heightPercent, float _str_wght, 
    color _c, float _wave_pct, float _angle_offset, boolean _useSine, float _counter_inc, 
    boolean _useCurves) {
    this.resolution  = _res;
    this.num_waves   = _nWaves;
    this.radius      = _r;
    this.wave_height = this.radius * _heightPercent;
    this.stroke_weight = _str_wght;
    this.c           = _c;
    this.wave_pct    = _wave_pct;
    this.sine        = _useSine;
    this.counter_increment = _counter_inc;
    this.angle_offset = _angle_offset;
    this.useCurves    = _useCurves;
  }

  void update() {
    this.counter -= this.counter_increment;

    ArrayList<PVector> new_pts = new ArrayList<PVector>();
    for (int i = 0; i < this.resolution; i++) {
      float angle = TWO_PI / this.resolution * i;

      float radius_addon = 0; 
      float speed_incrementer = counter / 5;

      if (i < this.wave_pct*this.resolution || i == resolution) {

        float smoothing_amount = 0.14;
        float smooth_pct = 1;

        if (i < wave_pct * resolution * smoothing_amount) {
          smooth_pct = i / (wave_pct * resolution * smoothing_amount);
        }

        if (i > wave_pct * resolution * (1 - smoothing_amount) && i <= wave_pct * resolution) {
          smooth_pct = (wave_pct * resolution - i) / (wave_pct * resolution * smoothing_amount);
        }

        if (i==resolution) {
          smooth_pct=0;
        }
        if (this.sine) {
          radius_addon = smooth_pct * this.wave_height * sin((angle+angle_offset+speed_incrementer)*this.num_waves);
        } else {
          radius_addon = smooth_pct * this.wave_height * cos((angle+angle_offset+speed_incrementer)*this.num_waves);
        }
      }

      float x = (this.radius + radius_addon) * cos(angle + speed_incrementer);
      float y = (this.radius + radius_addon) * sin(angle + speed_incrementer);

      PVector v = new PVector(x, y);
      new_pts.add(v);
    }
    this.pts = new_pts;
  }

  void display() {
    strokeWeight(this.stroke_weight);
    stroke(this.c);
    noFill();

    pushMatrix();
    translate(width/2, height/2);

    PVector last       = this.pts.get(this.pts.size() - 1);
    PVector first      = this.pts.get(0);

    beginShape();
    if (this.useCurves) {
      PVector nextLast       = this.pts.get(this.pts.size() - 2);
      curveVertex(nextLast.x, nextLast.y);
      curveVertex(last.x, last.y);
    } else {
      vertex(last.x, last.y);
    }

    for (PVector p : this.pts) {
      if (this.useCurves) {
        curveVertex(p.x, p.y);
      } else {
        vertex(p.x, p.y);
      }
    }
    if (this.useCurves) {
      curveVertex(first.x, first.y);
    } else {
      vertex(first.x, first.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}