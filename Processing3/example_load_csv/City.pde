class City {
  String name;
  float latitude, longitude;
  int areaCode;

  City(String _name, float _latitude, float _longitude, int _areaCode) {
    name      = _name;
    latitude  = _latitude;
    longitude = _longitude;
    areaCode  = _areaCode;
  }

  void display() {
    float mappedAreaCode = map(this.areaCode, 250, 950, 100, 255);
    color c = color(mappedAreaCode,150,255 - mappedAreaCode);
    fill(c);
    float x = map(this.longitude, minLongitude, maxLongitude, 50, width-50);

    // We have to reverse the y since we're working with 
    // coordinates from a normal cartesian plane
    float y = height - map(this.latitude, minLatitude, maxLatitude, 50, height-50);

    ellipse(x, y, 5, 5);

    if (abs(mouseX-x) < 5 && abs(mouseY-y) < 5 && !drawingAreaCode) {
      fill(0);
      drawingAreaCode = true;
      text(this.areaCode, 10, 50);
    }
  }
}