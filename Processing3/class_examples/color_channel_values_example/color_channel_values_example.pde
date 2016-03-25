int[] values = {0, 50, 87, 162, 209, 255};
void setup(){
 size(600,350); 
 // pixelDensity(2);
}

void draw(){
 background(255); 
 stroke(0);
 strokeWeight(1);
 textAlign(CENTER);
 
 for(int i = 0; i < values.length; i++){
   fill(values[i],0,0);
   rect(75 + i*75, 75, 75,75);
   
   fill(0,values[i],0);
   rect(75 + i*75, 160, 75,75);
   
   fill(0,0,values[i]);
   rect(75 + i*75, 245, 75,75);
   
   fill(0,0,0);
   text(values[i],112.5 + i*75, 50);
 }
}