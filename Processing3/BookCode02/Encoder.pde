class Encoder {
  color displayColor = color(0);
  boolean space      = true;
  boolean fillRows   = true;
  boolean makeSquare = false;

  int lettersPerRow = 6;

  int[][] hexcodes = { 
    {1, 0, 1, 0, 0, 1, 1, 1}, 
    {0, 1, 0, 1, 1, 1, 1, 0}, 
    {1, 0, 1, 1, 1, 1, 0, 1}, 
    {1, 1, 0, 1, 1, 0, 1, 1}, 
    {1, 1, 1, 1, 1, 0, 0, 1}, 
    {1, 1, 1, 1, 1, 0, 0, 0}, 
    {1, 0, 0, 1, 1, 1, 1, 1}, 
    {0, 0, 0, 1, 1, 1, 1, 1}, 
    {1, 1, 0, 1, 0, 0, 1, 1}, 
    {1, 0, 1, 1, 1, 1, 0, 0}, 
    {0, 1, 1, 0, 1, 0, 1, 1}, 
    {1, 1, 0, 1, 0, 1, 1, 0}, 
    {1, 0, 1, 1, 0, 1, 0, 1}, 
    {0, 1, 0, 1, 1, 0, 1, 1}, 
    {1, 1, 0, 1, 1, 0, 1, 0}, 
    {1, 0, 1, 0, 1, 1, 0, 1}};

  Encoder() {
  }

  void displayAt(String str, int scale, int xPos, int yPos) {
    pushMatrix();
    translate(xPos, yPos);
    display(str, scale);
    popMatrix();
  }

  void display(String str, int scale) {
    ArrayList<EncodedLetter> letters = encode(str);

    // Make square or fill rows?
    boolean addedStopLetter = false;

    if (fillRows) {
      if (letters.size() % lettersPerRow > 0) {
        EncodedLetter el = stopLetter();
        letters.add(el);
        addedStopLetter = true;
      }
      while (letters.size() % lettersPerRow > 0) {
        EncodedLetter el = randomLetter();
        letters.add(el);
      }
    }

    // Dangerous if already taller than wide!
    if (makeSquare) {
      while (letters.size() < lettersPerRow*lettersPerRow) {
        if (!addedStopLetter) {
          EncodedLetter el = stopLetter();
          letters.add(el);
          addedStopLetter = true;
        } else {
          EncodedLetter el = randomLetter();
          letters.add(el);
        }
      }
    }

    noStroke();
    fill(displayColor);

    int letterSpace = 4;
    if (space) {
      letterSpace = 5;
    }

    int letterRow = 0;

    for (int i = 0; i < letters.size(); i++) {
      EncodedLetter el = letters.get(i);

      int yAdjust = letterRow*letterSpace*scale;

      for (int j = 0; j < 4; j++) {
        int row0 = el.letterCode[0][j];
        int row1 = el.letterCode[1][j];
        int row2 = el.letterCode[2][j];
        int row3 = el.letterCode[3][j];

        int xPos = (i%lettersPerRow)*scale*letterSpace + scale*j;

        if (row0 == 1) {
          rect(xPos, yAdjust, scale, scale);
        }
        if (row1 == 1) {
          rect(xPos, scale + yAdjust, scale, scale);
        }
        if (row2 == 1) {
          rect(xPos, scale * 2 + yAdjust, scale, scale);
        }
        if (row3 == 1) {
          rect(xPos, scale * 3 + yAdjust, scale, scale);
        }
      }

      if (i%lettersPerRow == lettersPerRow - 1) {
        letterRow += 1;
      }
    }
  }

  ArrayList<EncodedLetter> encode(String str) {

    // Convert string to an array of bytes
    char[] chars = str.toCharArray();
    byte[] bytes = new byte[chars.length];
    for (int i = 0; i < chars.length; i++) {
      bytes[i] = (byte)chars[i];
    }

    // Convert bytes to an array of hex Strings
    String[] hexArray = new String[bytes.length];
    for (int i = 0; i < bytes.length; i++) {
      hexArray[i] = String.format("%02X", bytes[i]);
      // print(hexArray[i] + " ");
    }

    // Iterate through the hexArray. Each item is converted
    // to two symbols, one for each character in the string.

    ArrayList<EncodedLetter> encodedLetters = new ArrayList<EncodedLetter>();

    for (int i = 0; i < hexArray.length; i++) {
      String letter = hexArray[i];
      char[] parts  = letter.toCharArray();

      int[] topCode    = hexcodes[getIndexForChar(parts[0])];
      int[] bottomCode = hexcodes[getIndexForChar(parts[1])];

      EncodedLetter el = new EncodedLetter(topCode, bottomCode);
      encodedLetters.add(el);
    }
    return encodedLetters;
  }

  int getIndexForChar(char c) {
    if (c == 'A') {
      return 10;
    } else if (c == 'B') {
      return 11;
    } else if (c == 'C') {
      return 12;
    } else if (c == 'D') {
      return 13;
    } else if (c == 'E') {
      return 14;
    } else if (c == 'F') {
      return 15;
    } else {
      // convert to int and use as index
      return Integer.parseInt("" + c);
    }
  }

  EncodedLetter randomLetter() {
    int[] top    = hexcodes[(int)random(hexcodes.length)];
    int[] bottom = hexcodes[(int)random(hexcodes.length)];
    EncodedLetter el = new EncodedLetter(top, bottom);
    return el;
  }

  EncodedLetter stopLetter() {
    int[] top = hexcodes[4];
    int[] bottom = hexcodes[6];
    EncodedLetter el = new EncodedLetter(top, bottom);
    return el;
  }
}