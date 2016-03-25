class Voxel {
  float x, y, z;
  color c;
  Voxel(int _x, int _y, color _c) {
    x = _x;
    y = _y;
    c = _c;
    z = map(red(c),0,255,-100,100);
  }

  void display() {
    pushMatrix();
    translate(x,y,z);
    fill(c);
    stroke(c);
    sphere(1);
    popMatrix();
  }
}