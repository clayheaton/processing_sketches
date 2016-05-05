class DormRoomTemplate extends Template {
  int templateNumber;
  boolean leftDoor, rightDoor, topDoor, bottomDoor;

  String[][] layout;

  DormRoomTemplate(Table templateData) {
    printDebug("DormRoomTemplate: " + templateData.getInt(0, 0) + " created.");

    templateNumber = templateData.getInt(0, 0);
    layout = new String[templateData.getRowCount()][templateData.getColumnCount() - 1];

    // Iterate through the data specific for this template and put the values in an array. 
    for (int j = 0; j < templateData.getRowCount(); j++) {
      String[] rowData = new String[templateData.getColumnCount() - 1];
      for (int i = 1; i < templateData.getColumnCount(); i++) {
        String val = templateData.getString(j, i);
        rowData[i-1] = val;
      }
      layout[j] = rowData;
    }
  }

  // Move to parent class
  void instantiateOnGridAt(int cellX, int cellY) {
    printDebugBreak();
    for (int y = 0; y < layout.length; y++) {
      for (int x = 0; x < layout[y].length; x++) {
        String item = layout[y][x];
        if (item.startsWith("x") || item.length() == 0) {
          // Do nothing for now... 
        } else {
          String[] itemParts = item.split("-");
          GameObject go = database.gameObjects.get(itemParts[0]);
          PlacedGameObject pgo = new PlacedGameObject();
          pgo.gameObject = go;
          pgo.tileCoords = new PVector(cellX+x,cellY+y);
          pgo.drawAngle  = int(itemParts[1]);
          pgo.drawCoords = worldGrid.pixelsForCoordOrigin(cellX+x,cellY+y);
          pgo.adjustDrawCoords();
          
          database.placedGameObjects.add(pgo);
          
        }
      }
    }
  }
}