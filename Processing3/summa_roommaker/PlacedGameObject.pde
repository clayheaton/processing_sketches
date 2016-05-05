// These exist in the game world, can have ownership, etc... 
// they provide specifics on the definition of GameObject
class PlacedGameObject {
  GameObject gameObject;

  PVector tileCoords;
  PVector drawCoords;
  int     drawAngle;

  PlacedGameObject() {
  }

  void display() {
    pushMatrix();
    translate(drawCoords.x,drawCoords.y);
    rotate(radians(drawAngle));
    image(this.gameObject.objectImage, 0, 0);
    popMatrix();
  }

  void adjustDrawCoords() {
    switch(drawAngle) {
    case 90:
      drawCoords.x += unit_size - 1;
      break;
    case 180:
      drawCoords.x += unit_size - 1;
      drawCoords.y += unit_size - 1;
      break;
    case 270:
      drawCoords.y += unit_size - 1;
      break;
    default:
      break;
    }
  }
}