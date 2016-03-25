class Sector {
  PVector cornerPosition;
  PVector sectorCenter;

  float maxArcSize;

  color c1, c2, c3;

  float a1as, a1af, a2as, a2af, a3as, a3af;

  Sector(int _x, int _y) {
    cornerPosition  = new PVector(_x, _y);
    sectorCenter    = new PVector(_x + sector_w/2, _y + sector_h/2);
    maxArcSize = min(sector_w, sector_h);
    c1 = randomColor();
    c2 = randomColor();
    c3 = randomColor();

    float randomStartAngle = random(360);

    a1as = radians(randomStartAngle);
    a1af = radians(randomStartAngle + random(360));

    randomStartAngle = random(360);

    a2as = radians(randomStartAngle);
    a2af = radians(randomStartAngle + random(360));

    randomStartAngle = random(360);

    a3as = radians(randomStartAngle);
    a3af = radians(randomStartAngle + random(360));
  }

  void display() {
    noFill();
    stroke(c1);
    strokeWeight(3);
    arc(sectorCenter.x, sectorCenter.y, maxArcSize*0.2, maxArcSize*0.2, a1as, a1af);

    stroke(c2);
    strokeWeight(6);
    arc(sectorCenter.x, sectorCenter.y, maxArcSize*0.6, maxArcSize*0.6, a1as, a1af);

    stroke(c3);
    strokeWeight(9);
    arc(sectorCenter.x, sectorCenter.y, maxArcSize*0.9, maxArcSize*0.9, a1as, a1af);
  }

  color randomColor() {
    return color(random(255), random(255), random(255));
  }
}