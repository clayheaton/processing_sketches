/*
  Knows how to draw Flair components.
*/

class FlairSector extends Sector {
  Flair flair;
  FlairSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }
  
  void rebuild(){
    flair = new Flair();
  }
  
  void display(){
    if (debug) {
      debugDisplay();
    }
    
    pushMatrix();
    translate(this.center.x, this.center.y);
    this.flair.display();
    popMatrix();
  }
}
