class Rect {
  PVector pos;
  PVector size;

  PVector vel = new PVector(0, 0);

  Rect(PVector p, PVector s) {
    pos = p;
    size = s;
  }
}
