class GameObject {
  PImage objectImage;
  String name, debug_name, key_name, image_name;
  boolean allows_sitting, allows_lying, allows_walking;
  boolean is_furniture;

  GameObject(TableRow row) {
    image_name     = row.getString("image_name");
    objectImage    = loadImage(image_name);
    name           = row.getString("name");
    debug_name     = row.getString("debug_name");
    key_name       = row.getString("key_name");
    
    allows_sitting = row.getInt("allows_sitting") > 0 ? true : false;
    allows_lying   = row.getInt("allows_lying")   > 0 ? true : false;
    allows_walking = row.getInt("allows_walking") > 0 ? true : false;
    is_furniture   = row.getInt("is_furniture")   > 0 ? true : false;
    
    printDebug("GameObject: " + debug_name + " loaded...");
    
  }
}