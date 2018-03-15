class Cockpit {
  int w, h, r, g, b, bays;
  String type, windowStyle;
  Cockpit() {
    this.w = (int)random(cockpit_minWidth, cockpit_maxWidth);
    this.h = (int)random(cockpit_minHeight, cockpit_maxHeight);
    this.r = (int)random(cockpit_minRed, cockpit_maxRed);
    this.g = (int)random(cockpit_minGreen, cockpit_maxGreen);
    this.b = (int)random(cockpit_minBlue, cockpit_maxBlue);
    
    ArrayList<String> types = new ArrayList<String>();
    if (cockpit_type1) types.add("type1");
    if (cockpit_type2) types.add("type2");
    if (cockpit_type3) types.add("type3");
    
    // Must always have one type
    if (types.size() == 0) types.add("type1");
    
    // Pick a random type from the list
    type = types.get(new Random().nextInt(types.size()));
    
    ArrayList<String> windows = new ArrayList<String>();
    if (cockpit_window1) windows.add("window1");
    if (cockpit_window2) windows.add("window2");
    
    if (windows.size() == 0) windows.add("window1");
    
    windowStyle = windows.get(new Random().nextInt(windows.size()));
  }

  void display() {
  }
}
