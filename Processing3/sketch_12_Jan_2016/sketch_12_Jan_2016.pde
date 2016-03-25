// Theme: nested loops

int colorBound =  5;
int dimMin     = -5;
int dimMax     =  5;
int xMin       = -100;
int xMax       =  100;
int yMin       = -100;
int yMax       =  100;
int xJitterMin = -80;
int xJitterMax =  80;
int yJitterMin = -50;
int yJitterMax =  50;
int xJitterDenom = 10;
int yJitterDenom = 10;
float strokeMin  = 0.5;
float strokeMax  = 5;

int redMin = 0;
int redMax = 255;
int greenMin = 0;
int greenMax = 255;
int blueMin  = 0;
int blueMax  = 255;

int strokeAlpha = 5;

int angleCounter   = 1;
float angleMin     = 0;
float angleMax     = 1;
int angleJitterMin = 0;
int angleJitterMax = 0;

void setup(){
 size(600,600);
 background(255);
}

void draw(){
  noFill();
  background(255);
  for(int a = 0; a < colorBound; a++){
   for(int b = 0; b < colorBound*2; b++){
     for(int c = 0; c < colorBound*3; c++){
       for(int x = dimMin; x <= dimMax; x++){
          for(int y = dimMin; y <= dimMax; y++){
             for(int d = 0; d < angleCounter; d++){
               translate(width/2 + 2*x, height/4 + 2*y);
               float angle = map(d,0,angleCounter,angleMin,angleMax);
               float angleJitter = random(angleJitterMin,angleJitterMax);
               angle += angleJitter;
               rotate(radians(angle));
               stroke(map(a,0,colorBound,redMin,redMax),map(b,0,colorBound*2,greenMin,greenMax),map(c,0,colorBound*3,blueMin,blueMax),strokeAlpha);
               strokeWeight(map(a+b+c,0,colorBound*3,strokeMin,strokeMax));
               int xMapped = (int)map(x,dimMin,dimMax,xMin,xMax);
               int yMapped = (int)map(y,dimMin,dimMax,yMin,yMax);
               int xJitter = (int)random(xJitterMin,xJitterMax);
               int yJitter = (int)random(yJitterMin,yJitterMax);
               line(xJitter,yJitter,xMapped+xJitter,yMapped+yJitter);
               rotate(-radians(angle));
               translate(-(width/2 + 2*x),-(width/4 + 2*x));
             }
          }
       }
     }
   }
  }
  //println("done");
  //noLoop();
}