// Arbitrary Rectangle Collision Detection & Resolution 
//  13 Jul 2020 • javidx9
//  https://www.youtube.com/watch?v=8JJ-4JgR7Dg

ArrayList<Rect> vRects = new ArrayList<Rect>();

final int SCALE_FACTOR = 3;
void settings() {
  size(256 * SCALE_FACTOR, 240 * SCALE_FACTOR);
}

void setup() {
  vRects.add(new Rect(new PVector(10, 10), new PVector(30, 20)));
  vRects.add(new Rect(new PVector(100, 100), new PVector(80, 50)));
  vRects.add(new Rect(new PVector(150, 150), new PVector(80, 50)));
}

void draw() {
  scale(SCALE_FACTOR);
  PVector vMouse = new PVector(mouseX, mouseY).div(SCALE_FACTOR);

  if (mousePressed)
    vRects.get(0).vel.add(PVector.sub(vMouse, vRects.get(0).pos).normalize());

  for (int i = 1; i < vRects.size(); i++) {
    Collision c = DynamicRectVsRect(vRects.get(0), vRects.get(i));
    if (c.result) {
      //vRects.get(0).vel.mult(0);
      vRects.get(0).vel.add(elemmult(c.contact_normal, new PVector(abs(vRects.get(0).vel.x), abs(vRects.get(0).vel.y))));
      //vRects.get(0).vel.add(PVector.mult(elemmult(c.contact_normal, new PVector(abs(vRects.get(0).vel.x), abs(vRects.get(0).vel.y))), (1 - c.t_hit_near)));
    }
  }

  vRects.get(0).pos.add(vRects.get(0).vel);


  background(0, 0, 32);
  noFill();

  stroke(255);
  for (Rect r : vRects)
    rect(r.pos.x, r.pos.y, r.size.x, r.size.y);



  PVector ray_point = new PVector(20, 20);
  PVector ray_direction = PVector.sub(vMouse, ray_point);

  stroke(0, 255, 0);
  line(ray_point.x, ray_point.y, vMouse.x, vMouse.y);

  Collision c = RayVsRect(ray_point, ray_direction, vRects.get(1));
  PVector cp = c.contact_point;
  PVector cn = c.contact_normal;
  float t = c.t_hit_near;

  if (c.result && t < 1) {
    stroke(255, 0, 0);
    strokeWeight(3);
    point(cp.x, cp.y);
    strokeWeight(1);
    stroke(255, 255, 0);
    line(cp.x, cp.y, cp.x + cn.x * 10, cp.y + cn.y * 10);
  } else {
    stroke(255);
  }
  rect(vRects.get(1).pos.x, vRects.get(1).pos.y, vRects.get(1).size.x, vRects.get(1).size.y);
}
