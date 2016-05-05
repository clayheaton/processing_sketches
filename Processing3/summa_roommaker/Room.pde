class Room {
  PVector originCoords;
  int w, h;
  ArrayList<PlacedGameObject> placedGameObjects = new ArrayList<PlacedGameObject>();
  Room(int xCoord, int yCoord, int _w, int _h) {
    originCoords = new PVector(xCoord, yCoord);
    w = _w;
    h = _h;
  }
}