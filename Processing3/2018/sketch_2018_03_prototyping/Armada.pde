class Armada {
  Armada() {
  }

  void display() {
    fill(0, 0, 120);
    rect(-50, -50, 100, 100);
  }
}






class ArmadaSector extends Sector {
  Armada armada;
  ArmadaSector(int _x, int _y, PVector _corner, int _w, int _h) {
    super(_x, _y, _corner, _w, _h);
    rebuild();
  }
  void rebuild() {
    armada = new Armada();
  }

  void display() {
    if (debug) {
      debugDisplay();
    }

    pushMatrix();
    translate(this.center.x, this.center.y);
    this.armada.display();
    popMatrix();
  }
}




class ArmadaGrid extends Grid {
  ArmadaGrid(int _nx, int _ny, String _sectorType) {
    super(_nx, _ny, _sectorType);
    setRangeValues();
  }

  void createUIComponents() {
    armadasScaleRange = cp5.addRange("scale")
      .setBroadcast(false) 
      .setPosition(10, 30)
      .setSize(180, 30)
      .setHandleSize(20)
      .setRange(ARMADAS_MIN_SCALE, ARMADAS_MAX_SCALE)
      .setRangeValues(0.9, 1.1)
      .moveTo("armadas")
      .setBroadcast(true);
  }

  void setRangeValues() {
    armadas_minScale = ARMADAS_MIN_SCALE;
    armadas_maxScale = ARMADAS_MAX_SCALE;

    try {
      armadasScaleRange.setRangeValues(armadas_minScale, armadas_maxScale);
    }
    catch(NullPointerException e) {
    }
    finally {
    }
  }

  void handleEvents(ControlEvent theControlEvent) {
    if (theControlEvent.isFrom(armadasScaleRange)) {
      armadas_minScale = theControlEvent.getController().getArrayValue(0);
      armadas_maxScale = theControlEvent.getController().getArrayValue(1);
      println("armadas_minScale, armadas_maxScale: " + armadas_minScale + ", " + armadas_maxScale);
    }
  }

  void makeSectors() {
    int sectorW = (int)(width - UI_PANEL_WIDTH - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsAcross - 1))) / this.sectorsAcross;
    int sectorH = (int)(height - (GRID_OUTER_MARGIN * 2) - (GRID_INNER_MARGIN * (this.sectorsDown - 1))) / sectorsDown;

    for (int y = 0; y < sectorsDown; y++) {
      for (int x = 0; x < sectorsAcross; x++) {
        PVector secCorner = new PVector(x*sectorW + GRID_OUTER_MARGIN + (x * GRID_INNER_MARGIN) + UI_PANEL_WIDTH, y*sectorH + GRID_OUTER_MARGIN + (y * GRID_INNER_MARGIN));
        Sector s = null;
        s = new ArmadaSector(x, y, secCorner, sectorW, sectorH);
        if (null != s) {
          sectors[x][y] = s;
        }
      }
    }
  }
}
