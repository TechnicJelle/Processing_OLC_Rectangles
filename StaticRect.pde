class StaticRect {
  PVector pos;
  PVector size;

  boolean colliding = false;

  StaticRect(PVector p, PVector s) {
    pos = p;
    size = s;
  }

  void applyForce(PVector f) {
  }

  void update() {
  }

  void render() {
    noFill();
    if (colliding)
      stroke(255, 0, 0);
    else
      stroke(255);
    rect(pos.x, pos.y, size.x, size.y);
  }
}
