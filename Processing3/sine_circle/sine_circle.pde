WaveCircle wc, wc2, wc3;

void setup(){
  size(550,500);
  pixelDensity(2);
  
  wc  = new WaveCircle(100,12,200,0.05,7,color(#FF0000), 0.4, 0, true, 0.1, true);
  wc2 = new WaveCircle(100,12,200,0.1,7,color(#00FF00), 0.4, 0, false, 0.1, true);
  wc3 = new WaveCircle(100,12,200,0.15,7,color(#0000FF), 0.4, PI/180*45, false, 0.1, true);
}

void draw(){
  blendMode(ADD);
  background(30);
  
  wc.update();
  wc.display();
  
  wc2.update();
  wc2.display();
  
  wc3.update();
  wc3.display();
}