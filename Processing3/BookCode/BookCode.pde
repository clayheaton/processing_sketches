Encoder e;

int[] hexset1 = new int[6];
int[] hexset2 = new int[6];
int[] hexset3 = new int[6];
int[] hexset4 = new int[6];
int[] hexset5 = new int[6];
int[] hexset6 = new int[6];
int[] hexset7 = new int[6];
int[] hexset8 = new int[6];
int[] hexset9 = new int[6];

int randMax = 10000000;

void setup(){
  size(600,600);
  background(255);
  pixelDensity(2);
  
  e = new Encoder();
  
  for (int i = 0; i < 6; i++){
   hexset1[i] = (int)random(randMax); 
   hexset2[i] = (int)random(randMax);
   hexset3[i] = (int)random(randMax);
   hexset4[i] = (int)random(randMax);
   hexset5[i] = (int)random(randMax);
   hexset6[i] = (int)random(randMax);
   hexset7[i] = (int)random(randMax);
   hexset8[i] = (int)random(randMax);
   hexset9[i] = (int)random(randMax);
  }
}

void draw(){
  
  int scale = 3;
  int baseX = 10;
  int baseY = 10;
  
  e.displayHexsetAt(hexset1,scale,baseX,baseY);
  e.displayHexsetAt(hexset2,scale,baseX + (24*scale),baseY);
  e.displayHexsetAt(hexset3,scale,baseX + (2*24*scale),baseY);
  
  // e.fillColor = color(255,0,0);
  e.displayHexsetAt(hexset4,scale,baseX,baseY + (24*scale));
  e.displayHexsetAt(hexset5,scale,baseX + (24*scale),baseY + (24*scale));
  e.displayHexsetAt(hexset6,scale,baseX + (2*24*scale),baseY + (24*scale));
  
  // e.fillColor = color(255,0,255);
  e.displayHexsetAt(hexset7,scale,baseX,baseY + (2*24*scale));
  e.displayHexsetAt(hexset8,scale,baseX + (24*scale),baseY + (2*24*scale));
  e.displayHexsetAt(hexset9,scale,baseX + (2*24*scale),baseY + (2*24*scale));
  
  // e.displayHexsetAt(hexset1,10,100,100);
  // e.displayAt(12345,10,100,100);
  
  noLoop();
}

// Get number
// Convert to hex
// Look up hex symbox in array
// concatenate hex symbols.