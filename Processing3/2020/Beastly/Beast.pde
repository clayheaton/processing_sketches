// Based on work by Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Video: https://youtu.be/hbgDqyy8bIw

class Beast {
  BeastSegment tentacle;
  Beast(int _numSegments) {
    float len = (width/2)/_numSegments;
    BeastSegment current = new BeastSegment(width/2, 20, len);
    for (int i = 1; i < _numSegments; i++){
     BeastSegment next = new BeastSegment(current, len);
     current.child = next;
     current = next;
    }
    tentacle = current;
  }
  
  void display(){
   tentacle.follow(mouseX, mouseY);
   tentacle.update();
   tentacle.display();
   
   BeastSegment next = tentacle.parent;
   while (next != null) {
    next.follow();
    next.update();
    next.display();
    next = next.parent;
   }
  }
}
