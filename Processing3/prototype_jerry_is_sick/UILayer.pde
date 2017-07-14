class UILayer {
  color bgColor;
  int pixelsTall;
  
 UILayer(){
   
 }
 
 void display(){
  noStroke();
  fill(this.bgColor);
  rect(0,height-pixelsTall,width,this.pixelsTall);
 }
}