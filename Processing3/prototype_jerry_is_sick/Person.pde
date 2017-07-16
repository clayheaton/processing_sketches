class Person {
  int state;
  boolean personRotates;
  float direction;
  int directionNumber;
  Person() {
    this.state = STATE_HEALTHY;
    
    int will_rotate_num = int(random(0, 100));
    if (will_rotate_num > 70) {
      this.personRotates = true;
    } else {
      this.personRotates = false;
    }
    
    this.directionNumber = int(random(0, 8));
    setRotation(this.directionNumber);
  }
  
  void advanceTurn(){
    // Rotate if person rotates
    if (this.state == STATE_HEALTHY){
      if (this.personRotates){
        this.directionNumber += 1;
        if (this.directionNumber > 7){
           this.directionNumber = 0; 
        }
        setRotation(this.directionNumber);
      }
    }
  }

  void setRotation(int num) {
    switch(num) {
    case 0:
      this.direction = DIRECTION_E;  
      break;
    case 1:
      this.direction = DIRECTION_NE; 
      break;
    case 2:
      this.direction = DIRECTION_N;  
      break;
    case 3:
      this.direction = DIRECTION_NW; 
      break;
    case 4:
      this.direction = DIRECTION_W;  
      break;
    case 5:
      this.direction = DIRECTION_SW; 
      break;
    case 6:
      this.direction = DIRECTION_S;  
      break;
    case 7:
      this.direction = DIRECTION_SE; 
      break;
    default:
      this.direction = DIRECTION_E;  
      break;
    }
  }

  void display() {
    ellipseMode(CENTER);
    if (this.state == STATE_HEALTHY) {
      fill(255);
    } else if (this.state == STATE_INFECTED) {
      fill(100, 255, 100);
    } else if (this.state == STATE_CONTAGIOUS) {
      fill(255, 100, 100);
    } else if (this.state == STATE_IMMUNE) {
      fill(100, 100, 255);
    } else if (this.state == STATE_DEAD) {
      fill(0);
    }
    ellipse(0, 0, 40, 40);
    strokeWeight(1);
    if (this.personRotates) {
      stroke(255, 0, 0);
    } else {
      stroke(0);
    }
    line(0, 0, 25, 0);
  }
}