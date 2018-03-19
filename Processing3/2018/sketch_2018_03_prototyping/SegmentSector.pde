class SegmentSector extends Sector {
  Segment segment;
  SegmentSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }
    void rebuild(){
    segment = new Segment();
  }
  
  void display(){
    if (debug) {
      debugDisplay();
    }
    
    pushMatrix();
    translate(this.center.x, this.center.y);
    this.segment.display();
    popMatrix();
  }
}
