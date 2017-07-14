class Sector {
  int xCoord,yCoord;
  int w,h;
  Person sectorPerson;
  PVector position;
   Sector(int _xCoord, int _yCoord, PVector _pos, int _w, int _h){
     this.w = _w;
     this.h = _h;
     this.xCoord = _xCoord;
     this.yCoord = _yCoord;
     this.position = _pos;
     this.sectorPerson = new Person();
   }
   
   void display(){
     if (debug){
       stroke(0);
       strokeWeight(0.5);
       fill(230,230,230);
       textAlign(LEFT);
       
       pushMatrix();
         translate(this.position.x,this.position.y);
         rect(0,0,this.w,this.h);
         textSize(10);
         fill(0);
         text("(" + xCoord + ", " + yCoord + ")",4,11);
       popMatrix();
     }
     
     // Draw the person in the sector
     pushMatrix();
       translate(this.position.x + this.w/2, this.position.y + this.h/2);
       rotate(this.sectorPerson.direction);
       this.sectorPerson.display();
       rotate(-this.sectorPerson.direction);
     popMatrix();
   }
}