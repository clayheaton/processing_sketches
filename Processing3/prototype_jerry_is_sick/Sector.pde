class Sector {
  int xCoord, yCoord;
  int w, h;
  Person sectorPerson;
  PVector position;
  boolean isUnderMousePointer;
  boolean isSelected;


  Sector(int _xCoord, int _yCoord, PVector _pos, int _w, int _h) {
    this.w = _w;
    this.h = _h;
    this.xCoord = _xCoord;
    this.yCoord = _yCoord;
    this.position = _pos;
    this.sectorPerson = new Person();
    this.isSelected = false;
    this.isUnderMousePointer = false;
  }

  void checkHover() {
    if (mouseOverUI()) {
      this.isUnderMousePointer = false;
      return;
    }

    if (this.isSelected) {
      this.isUnderMousePointer = false;
    } else {
      if (mouseX - offsetX > this.position.x && 
        mouseX - offsetX < this.position.x + this.w &&
        mouseY - offsetY > this.position.y &&
        mouseY - offsetY < this.position.y + this.h) {
        this.isUnderMousePointer = true;
      } else {
        this.isUnderMousePointer = false;
      }
    }
  }

  void selectCheck() {
    if (mouseX - offsetX > this.position.x && 
      mouseX - offsetX < this.position.x + this.w &&
      mouseY - offsetY > this.position.y &&
      mouseY - offsetY < this.position.y + this.h) {
      this.isSelected = true;
      
      // Tell the grid that this is the selected sector
      gameGrid.selectedSector.x = this.xCoord;
      gameGrid.selectedSector.y = this.yCoord;
    } else {
      this.isSelected = false;
    }
  }
  
  void setState(int newState){
    this.sectorPerson.setState(newState);
  }

  void advanceTurn() {
    this.sectorPerson.advanceTurn();
  }

  void display() {
    if (debug) {
      stroke(0);
      strokeWeight(0.5);

      checkHover();
      if (this.isUnderMousePointer) {
        fill(200, 200, 200);
      } else if (this.isSelected) {
        fill(128, 128, 128);
      } else {
        fill(255, 255, 255);
      }

      textAlign(LEFT);

      pushMatrix();
      translate(this.position.x, this.position.y);
      if (this.isUnderMousePointer || this.isSelected){
        rect(0, 0, this.w, this.h);
      }
      // textSize(10);
      // fill(0);
      // text("(" + xCoord + ", " + yCoord + ")", 4, 11);
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