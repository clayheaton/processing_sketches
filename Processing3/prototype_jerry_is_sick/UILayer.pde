class UILayer {
  color bgColor;
  int pixelsTall;
  ArrayList<AttackButton> attackButtons;
  float attackButtonOffsetHorizontal, attackButtonOffsetVertical;

  UILayer(int _pixelsTall, color _bgColor) {
    this.pixelsTall = _pixelsTall;
    this.bgColor = _bgColor;

    this.attackButtonOffsetHorizontal = width / 6;
    this.attackButtonOffsetVertical   = this.pixelsTall / 2;

    this.attackButtons = new ArrayList<AttackButton>();
    createAttackButtons();
  }

  boolean catchingMouse() {
    if (mouseY > height - this.pixelsTall) {
      return true;
    }
    return false;
  }

  PVector buttonPosition(int uiPosition) {
    float hOffset = uiPosition * this.attackButtonOffsetHorizontal + (this.attackButtonOffsetHorizontal/2);
    float vOffset = this.attackButtonOffsetVertical;
    return new PVector(hOffset, height - vOffset);
  }

  void checkMouseClick() {
    for (AttackButton ab : attackButtons) {
      PVector buttonPos = buttonPosition(ab.uiPosition);
      PVector mousePos = new PVector(mouseX,mouseY);
      float dist = buttonPos.dist(mousePos);
      if (dist <= ab.buttonRadius){
        ab.processClick();
        return;
      }
    }
  }

  void createAttackButtons() {
    AttackButton b0 = new AttackButton(ATTACK_COUGH, 0);
    AttackButton b1 = new AttackButton(ATTACK_SNEEZE, 1);
    AttackButton b2 = new AttackButton(ATTACK_HUG, 2);
    AttackButton b3 = new AttackButton(ATTACK_KISS, 3);
    AttackButton b4 = new AttackButton(ATTACK_SPIT, 4);
    AttackButton b5 = new AttackButton(ATTACK_VOMIT, 5);

    attackButtons.add(b0);
    attackButtons.add(b1);
    attackButtons.add(b2);
    attackButtons.add(b3);
    attackButtons.add(b4);
    attackButtons.add(b5);
  }

  void display() {
    noStroke();
    fill(this.bgColor);
    rect(0, height-pixelsTall, width, this.pixelsTall);
    displayAttackButtons();
  }

  void displayAttackButtons() {
    ellipseMode(CENTER);
    for (AttackButton ab : attackButtons) {
      PVector buttonPos = buttonPosition(ab.uiPosition);
      pushMatrix();
      translate(buttonPos.x, buttonPos.y);
      ab.display();
      popMatrix();
    }
  }
}