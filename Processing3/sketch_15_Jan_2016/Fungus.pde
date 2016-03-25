class Fungus {
  int radius, layers;
  Fungus(int _radius, int _layers) {
    radius = _radius;
    layers = _layers;
  }

  void display() {
    for (int i = this.layers; i > 0; i--) {
      float rad = this.radius * (float)i/this.layers;
      for (int j = 0; j < (int)random(3, 5); j++) {
        int widthOffset = (int)random(-width/20,width/20);
        int heightOffset = (int)random(-height/20,height/20);
        FungusLeaf fl = new FungusLeaf(width/2 + widthOffset,height/2 + heightOffset,random(TWO_PI),rad);
        fl.display();
      }
    }
  }
}