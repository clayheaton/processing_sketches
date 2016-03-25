Table table;

float minLatitude, maxLatitude, minLongitude, maxLongitude;

ArrayList<City> cities;

PFont f;

boolean drawingAreaCode;

void setup() {
  size(900, 400);
  cities = new ArrayList<City>();
  f = createFont("Arial-Black", 36);
  textFont(f);

  minLatitude = 9999;
  maxLatitude = -9999;
  minLongitude = 9999;
  maxLongitude = -9999;

  table = loadTable("nc.csv", "header");

  for (TableRow row : table.rows()) {
    String city = row.getString("city");
    int areaCode = row.getInt("areaCode");

    float lat = row.getFloat("latitude");
    float lon = row.getFloat("longitude");

    // Determine global min and max lat and lon values
    if (lat > maxLatitude) {
      maxLatitude = lat;
    }

    if (lat < minLatitude) {
      minLatitude = lat;
    }

    if (lon > maxLongitude) {
      maxLongitude = lon;
    }

    if (lon < minLongitude) {
      minLongitude = lon;
    }

    // Create the city object
    City c = new City(city, lat, lon, areaCode);
    cities.add(c);
  }
  background(255);
  noStroke();
}

void draw() {
  drawingAreaCode = false;
  background(255);
  for (City c : cities) {
    c.display();
  }
}