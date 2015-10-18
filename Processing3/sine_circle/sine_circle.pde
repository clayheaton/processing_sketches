WaveCircle wc, wc2, wc3;

void setup(){
  size(550,500);
  pixelDensity(2);
  
  wc  = new WaveCircle(1000,12,200,0.1,color(#5593DD), 0.4, 0, true, 0.1);
  wc2 = new WaveCircle(1000,12,200,0.1,color(#5549DD), 0.4, 0, false, 0.1);
  wc3 = new WaveCircle(1000,12,200,0.1,color(#55C9DD), 0.4, PI/180*45, false, 0.1);
}

void draw(){
  background(30);
  
  wc.update();
  wc.display();
  
  wc2.update();
  wc2.display();
  
  wc3.update();
  wc3.display();
}