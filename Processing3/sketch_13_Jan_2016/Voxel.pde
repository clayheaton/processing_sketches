class Voxel {
  float x, y, z;
  color c;
  Voxel(int _x, int _y, color _c) {
    x = _x;
    y = _y;
    c = _c;
  }

  void display() {
    pushMatrix();
    translate(x,y,0);
    fill(c);
    box(5);
    popMatrix();
  }
}