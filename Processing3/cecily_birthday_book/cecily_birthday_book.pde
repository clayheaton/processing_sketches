 PImage boodle;
 
 void setup(){
   size(768,1024);
   boodle = loadImage("cecily.jpg");
   boodle.loadPixels();
   
   background(255);
   smooth();
 }
 
 void draw(){
   // background(255);
   
   int randomX = (int)random(width);
   int randomY = (int)random(height);
   
   color c = boodle.pixels[randomY * width + randomX ];
   float v = brightness(c);
   //v = map(v,0,255,0,255);
   fill(c,v);
   noStroke();
   
   float diam = map(v,0,255,30,5);
   
   ellipse(randomX,randomY,diam,diam);
   
 }