ArrayList<PVector> pts = new ArrayList<PVector>();

void setup(){
 size(550,500);
 background(255);
 stroke(0);
 noFill();
}

void draw(){
  background(255);
  if(pmouseX == 0 && pmouseY == 0){
    //skip
  } else {
    PVector p = new PVector (mouseX,mouseY);
    pts.add(p);
    if (pts.size() > 50) {
     pts.remove(0); 
    }
    for (int i = 1; i < pts.size(); i++){
      PVector last = pts.get(i-1);
      PVector curr = pts.get(i);
      line(last.x,last.y,curr.x,curr.y);
    }
  }
}