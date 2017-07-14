// Numeric conversion of a String:
// letter -> ascii code -> ascii code in hexadecimal notation
// hex -> number range 1-16

class Encoder {
  boolean makeSquare     = false;
  boolean allowShift     = false;
  boolean dynamicDensity = false;
  int densityMin         = 4;
  int densityMax         = 7;
  int symbolDiam         = 50;
  int symbolsPerRow      = 10;

  // String is broken up into these objects.
  // Each encoded symbol can hold multiple letters,
  // determined by the densityMin and densityMax settings.
  ArrayList<LetterGrouping> letterGroupings;

  String encodedString;

  Encoder(String _toEncode, int _symbolDiam, int _symbolsPerRow) {
    this.encodedString = _toEncode;
    this.symbolDiam    = _symbolDiam;
    this.symbolsPerRow = _symbolsPerRow;

    letterGroupings    = new ArrayList<LetterGrouping>();

    this.encode();
  }

  void displayCode() {
    int row = -1;
    
    for (int i = 0; i < letterGroupings.size(); i++) {
      if(i % this.symbolsPerRow == 0){
         row += 1; 
      }
      int col = i % this.symbolsPerRow;
      
      pushMatrix();
      int xPadding = col * padding;
      int yPadding = row * padding;
      translate(xPadding + margin + this.symbolDiam/2.0 + col*this.symbolDiam,
                yPadding + margin + this.symbolDiam/2.0 + row*this.symbolDiam);
      LetterGrouping lg = letterGroupings.get(i);
      lg.displayGrouping(this.symbolDiam);
      popMatrix();
      
    }
  }

  void encode() {
    char[] chars     = this.encodedString.toCharArray();
    int currentIndex = 0;

    while (currentIndex < chars.length) {
      int numLettersInGrouping = (int)random(densityMin, densityMax);
      numLettersInGrouping     = min(chars.length - currentIndex, numLettersInGrouping);
      char[] charsForGrouping  = new char[numLettersInGrouping];

      for (int i = 0; i < numLettersInGrouping; i++) {
        charsForGrouping[i] = chars[currentIndex + i];
      }

      currentIndex += numLettersInGrouping;
      // Store the grouping
      LetterGrouping lg = new LetterGrouping(charsForGrouping);
      letterGroupings.add(lg);
    }
  }
}