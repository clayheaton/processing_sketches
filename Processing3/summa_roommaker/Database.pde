class Database {
  HashMap<String, GameObject> gameObjects;
  ArrayList<PlacedGameObject> placedGameObjects = new ArrayList<PlacedGameObject>();
  
  ArrayList<DormRoomTemplate> dormRoomTemplates = new ArrayList<DormRoomTemplate>();

  Database() {
    gameObjects = new HashMap<String, GameObject>();
  }

  void loadGameObjects(String datafile) {
    Table rawTable = loadTable(datafile, "header");
    printDebugBreak();
    printDebug(rawTable.getRowCount() + " total rows in GameObjects table");

    for (TableRow t : rawTable.rows()) {
      GameObject go = new GameObject(t);
      gameObjects.put(t.getString("key_name"), go);
    }
  }

  void loadDormRoomTemplates(String datafile) {
    printDebugBreak();
    Table rawTable = loadTable(datafile);

    int prefabNumber = -1;
    Table templateTable = new Table();

    for (TableRow tr : rawTable.rows()) {
      // Finished iterating a template, so create the template
      if (prefabNumber > -1 && tr.getInt(0) > 0) {
        if (tr.getInt(0) != prefabNumber) {
          DormRoomTemplate drt = new DormRoomTemplate(templateTable);
          dormRoomTemplates.add(drt);
        }
      }

      // New template, so reinitialize the table
      if (tr.getInt(0) != prefabNumber) {

        // Skip padding rows
        if (tr.getInt(0) == 0) continue;

        prefabNumber  = tr.getInt(0);
        templateTable = new Table();
      }
      templateTable.addRow(tr);
    }

    // Handle the final template
    DormRoomTemplate drt = new DormRoomTemplate(templateTable);
    dormRoomTemplates.add(drt);
  }
}