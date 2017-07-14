class LetterGrouping {
  char[] letters;

  // Use an ArrayList of PVectors to store the
  // start and stop angle for each letter
  ArrayList<PVector> angles;

  float offsetAngle = 0;
  int offsetAngleMax = 18;

  LetterGrouping(char[] _letters) {
    this.letters = _letters;
    angles       = new ArrayList<PVector>();
    offsetAngle  = (int)random(6) * 60;
    encodeGrouping();
  }
  
  void displayGrouping(float outerDiameter){
    // Offset
    strokeWeight(max(min(outerDiameter/10.0,2),1));
    strokeCap(SQUARE);
    stroke(255,0,0);
    noFill();
    float arcStart = radians(offsetAngle - 30);
    float arcEnd   = radians(offsetAngle + 30);
    arc(0,0,outerDiameter,outerDiameter,arcStart,arcEnd);
    
    float diamStep = (outerDiameter / angles.size() + 1) *0.6;
    
    fill(0,20);
    stroke(0);
    // Draw from the outside in
    for (int i = angles.size()-1; i >= 0; i--){
      PVector angle = angles.get(i);
      arcStart = radians(angle.x);
      arcEnd   = radians(angle.y);
      float diamDiff = diamStep * (angles.size() - i); 
      float diam = outerDiameter - diamDiff;
      arc(0,0,diam,diam,arcStart,arcEnd);
    }
  }

  void encodeGrouping() {
    println();
    println("LetterGrouping: ");
    println(letters);

    for (int i = 0; i < letters.length; i++) {
      println("   Working with: " + letters[i]);
      byte charAsByte  = (byte)letters[i];
      println("     '" + letters[i] + "' as byte: " + charAsByte);
      
      String byteAsHex = String.format("%02X", charAsByte);
      println("     " + charAsByte + " as hexString: " + byteAsHex);
      
      // Now we should have a two char string. Could be more?
      char[] hexStringChars = byteAsHex.toCharArray();

      // Convert those chars to angle stops
      int charAngleStart = getAngleStopForChar(hexStringChars[0]);
      println("     " + hexStringChars[0] + " as charAngleStart: " + charAngleStart);
      
      int charAngleStop  = getAngleStopForChar(hexStringChars[1]);
      println("     " + hexStringChars[1] + " as charAngleStop: " + charAngleStop);
      
      // The angles are additive for display, so the domain is 1-32
      float startAngle = map(charAngleStart,1,offsetAngleMax,0,360) + offsetAngle;
      float stopAngle  = map(charAngleStart + charAngleStop,1,offsetAngleMax,0,360) + offsetAngle;
      
      PVector anglesForChar = new PVector(startAngle,stopAngle);
      angles.add(anglesForChar);
      println("     anglesForChar: " + anglesForChar);
    }
  }

  int getAngleStopForChar(char c) {
    if (c == 'A') {
      return 11;
    } else if (c == 'B') {
      return 12;
    } else if (c == 'C') {
      return 13;
    } else if (c == 'D') {
      return 14;
    } else if (c == 'E') {
      return 15;
    } else if (c == 'F') {
      return 16;
    } else {
      // convert to int and add one
      return Integer.parseInt("" + c) + 1;
    }
  }
}