class DynamicRect extends StaticRect {
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  
  DynamicRect(PVector p, PVector s) {
    super(p, s);
  }
  
  void applyForce(PVector f) {
    acc.add(f.copy());
  }
  
  void update() {
    applyForce(new PVector(0, 0.1));
    
    vel.add(acc);
    vel.mult(0.98);
    
    colliding = false;
    
    println("bvel: " + vel);
    for (StaticRect sr : vStaticRects) {
      if (this == sr) continue;
      Collision c = DynamicRectVsStaticRect(this, sr);
      if (c.result) {
        //vStaticRects.get(0).vel.mult(0);
        vel.add(elemmult(c.contact_normal, new PVector(abs(vel.x), abs(vel.y))));
        line(c.contact_point.x, c.contact_point.y, c.contact_point.x + 10*c.contact_normal.x, c.contact_point.y + 10*c.contact_normal.y);
        //vStaticRects.get(0).vel.add(PVector.mult(elemmult(c.contact_normal, new PVector(abs(vStaticRects.get(0).vel.x), abs(vStaticRects.get(0).vel.y))), (1 - c.t_hit_near)));
        colliding = true;
      }
    }
    
    println("avel: " + vel);
    pos.add(vel);
    acc.mult(0);
  }
}
