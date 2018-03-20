class Ship {
  Ship() {
  }

  void display() {
    fill(120, 0, 0);
    rect(-50, -50, 100, 100);
  }
}



class ShipSector extends Sector {
  Ship ship;
  ShipSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }
  void rebuild() {
    ship = new Ship();
  }

  void display() {
    if (debug) {
      debugDisplay();
    }

    pushMatrix();
    translate(this.center.x, this.center.y);
    this.ship.display();
    popMatrix();
  }
}


class ShipGrid extends Grid {
  ShipGrid(int _nx, int _ny, String _sectorType) {
    super(_nx, _ny, _sectorType);
    setRangeValues();
  }
  void createUIComponents() {
    shipsSegmentsRange = cp5.addRange("segments")
      .setBroadcast(false) 
      .setPosition(10, 30)
      .setSize(180, 30)
      .setHandleSize(20)
      .setRange(SHIPS_MIN_SEGMENTS, SHIPS_MAX_SEGMENTS)
      .setRangeValues(SHIPS_MIN_SEGMENTS, SHIPS_MAX_SEGMENTS)
      .moveTo("ships")
      .setBroadcast(true);

    shipsAmplitudeRange = cp5.addRange("bendiness")
      .setBroadcast(false) 
      .setPosition(10, 70)
      .setSize(180, 30)
      .setHandleSize(20)
      .setRange(SHIPS_MIN_AMPLITUDE, SHIPS_MAX_AMPLITUDE)
      .setRangeValues(SHIPS_MIN_AMPLITUDE, SHIPS_MAX_AMPLITUDE)
      .moveTo("ships")
      .setBroadcast(true);

    shipsWingPositions = cp5.addCheckBox("wing positions")
      .setPosition(10, 150)
      .setSize(30, 30)
      .setItemsPerRow(3)
      .setSpacingColumn(50)
      .setSpacingRow(20)
      .addItem("top", 1)
      .addItem("bottom", 2)
      .moveTo("ships")
      .toggle(0)
      .toggle(1)
      ;
  }

  void setRangeValues() {
    ships_minSegments = SHIPS_MIN_SEGMENTS;
    ships_maxSegments = SHIPS_MAX_SEGMENTS;
    ships_minAmplitude = SHIPS_MIN_AMPLITUDE;
    ships_maxAmplitude = SHIPS_MAX_AMPLITUDE;

    ships_wingsTop = true;
    ships_wingsBottom = true;


    try {
      shipsSegmentsRange.setRangeValues(ships_minSegments, ships_maxSegments);
      shipsAmplitudeRange.setRangeValues(ships_minAmplitude, ships_maxAmplitude);

      float[] v = {1, 1};
      shipsWingPositions.setArrayValue(v);
    }
    catch(NullPointerException e) {
    }
    finally {
    }
  }

  void handleEvents(ControlEvent theControlEvent) {
    if (theControlEvent.isFrom(shipsSegmentsRange)) {
      ships_minSegments = int(theControlEvent.getController().getArrayValue(0));
      ships_maxSegments = int(theControlEvent.getController().getArrayValue(1));
      println("ships_minSegments, ships_maxSegments: " + ships_minSegments + ", " + ships_maxSegments);
    }

    if (theControlEvent.isFrom(shipsAmplitudeRange)) {
      ships_minAmplitude = theControlEvent.getController().getArrayValue(0);
      ships_maxAmplitude = theControlEvent.getController().getArrayValue(1);
      println("ships_minAmplitude, ships_maxAmplitude: " + ships_minAmplitude + ", " + ships_maxAmplitude);
    }

    if (theControlEvent.isFrom(shipsWingPositions)) {
      ships_wingsTop = int(cockpitCheckbox.getArrayValue()[0]) == 1 ? true : false;
      ships_wingsBottom = int(cockpitCheckbox.getArrayValue()[1]) == 1 ? true : false;
      println("shipsWingPositions: ");
      println(shipsWingPositions.getArrayValue());
    }
  }

  void makeSectors() {
    int sectorW = (int)(width - UI_PANEL_WIDTH - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsAcross - 1))) / this.sectorsAcross;
    int sectorH = (int)(height - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsDown - 1))) / sectorsDown;

    for (int y = 0; y < sectorsDown; y++) {
      for (int x = 0; x < sectorsAcross; x++) {
        PVector secCorner = new PVector(x*sectorW + GRID_OUTER_MARGIN + (x * GRID_INNER_MARGIN) + UI_PANEL_WIDTH, y*sectorH + GRID_OUTER_MARGIN + (y * GRID_INNER_MARGIN));
        Sector s = null;
        s = new ShipSector(x, y, secCorner, sectorW, sectorH);
        if (null != s) {
          sectors[x][y] = s;
        }
      }
    }
  }
}
