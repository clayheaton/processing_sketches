class AttackButton {
  int attackType;
  int uiPosition;
  int backgroundColor, textColor;
  int buttonRadius = 30;
  String buttonText;

  AttackButton(int _attackType, int _uiPosition) {
    this.attackType = _attackType;
    this.uiPosition = _uiPosition;
    setProperties();
  }

  void setProperties() {
    this.textColor = color(255);

    switch(this.attackType) {
      case ATTACK_COUGH:
        this.backgroundColor = color(#6bdcec);
        this.buttonText = "cough";
        break;
      case ATTACK_SNEEZE:
        this.backgroundColor = color(#67c6db);
        this.buttonText = "sneeze";
        break;
      case ATTACK_HUG:
        this.backgroundColor = color(#f9e153);
        this.buttonText = "hug";
        break;
      case ATTACK_KISS:
        this.backgroundColor = color(#fb4e4e);
        this.buttonText = "kiss";
        break;
      case ATTACK_SPIT:
        this.backgroundColor = color(#6693d0);
        this.buttonText = "spit";
        break;
      case ATTACK_VOMIT:
        this.backgroundColor = color(#99c419);
        this.buttonText = "vomit";
        break;
      default:
        this.backgroundColor = color(128);
        break;
    }
  }
  
  void processClick(){
    println(this.buttonText + " clicked.");
  }
  
  void display(){
    stroke(255);
    strokeWeight(2);
    fill(this.backgroundColor);
    ellipse(0,0,buttonRadius*2,buttonRadius*2);
    fill(this.textColor);
    textAlign(CENTER);
    textSize(16);
    text(this.buttonText,0,6);
  }
}