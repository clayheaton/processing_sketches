color colorfrom = color(4, 175, 255);
color colorto   = color(255, 0, 196);

void setup() {
  size(1420, 360);
  background(255);
}

void draw() {
  // blue: 4,175,255
  // pink: 255,0,196

  for(int i = -15; i < 86; i++){
     for(int j = -15; j < 33; j++){
       float total   = float(71 + 18);
       float present = float(i + j);
       float lerpValue = present / total; 
       color thissquare = lerpColor(colorfrom, colorto, lerpValue);
       color backsquare = lerpColor(colorto,colorfrom,lerpValue);
       
       noStroke();
       fill(backsquare);
       pushMatrix();
       rotate(PI/present*-0.5);
       rect(20*i,20*j,15,15);
       popMatrix();
       
       stroke(255);
        strokeWeight(1);
        noStroke();
        pushMatrix();
        rotate(PI/present);
       fill(thissquare);
       rect(20*i,20*j,max(8,20*lerpValue),max(8,20*lerpValue));
       popMatrix();
     
     } 
  }
 

}

