// Arbitrary StaticRectangle Collision Detection & Resolution 
//  13 Jul 2020 • javidx9
//  https://www.youtube.com/watch?v=8JJ-4JgR7Dg

ArrayList<StaticRect> vStaticRects = new ArrayList<StaticRect>();

final int SCALE_FACTOR = 3;
void settings() {
  size(256 * SCALE_FACTOR, 240 * SCALE_FACTOR);
}

void setup() {
  vStaticRects.add(new DynamicRect(new PVector(10, 10), new PVector(30, 20)));
  vStaticRects.add(new StaticRect(new PVector(100, 100), new PVector(80, 50)));
  vStaticRects.add(new StaticRect(new PVector(150, 150), new PVector(80, 50)));
}

void draw() {
  println("-- new frame --");
  scale(SCALE_FACTOR);
  PVector vMouse = new PVector(mouseX, mouseY).div(SCALE_FACTOR);

  if (mousePressed)
    vStaticRects.get(0).applyForce(PVector.sub(vMouse, vStaticRects.get(0).pos).normalize());

  background(0, 0, 32);
  for (StaticRect r : vStaticRects) {
    r.update();
    r.render();
  }



  //Other ray
  PVector ray_point = new PVector(20, 20);
  PVector ray_diStaticRection = PVector.sub(vMouse, ray_point);

  stroke(0, 255, 0);
  line(ray_point.x, ray_point.y, vMouse.x, vMouse.y);

  Collision c = RayVsRect(ray_point, ray_diStaticRection, vStaticRects.get(1));
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
  rect(vStaticRects.get(1).pos.x, vStaticRects.get(1).pos.y, vStaticRects.get(1).size.x, vStaticRects.get(1).size.y);
}
