class Collider {
  float strength = 100;
  PVector location;
  float width;

  Collider (float x, float y, float w) {
    location = new PVector(x, y);
    width = w;
 }

  void display() {
    stroke(255);
    fill(255);
    rect(location.x,location.y,width * 2,width *2, 10);
  }

 PVector repel(Particle p) {
    PVector dir = PVector.sub(location, p.position);
    float d = dir.mag();
    dir.normalize(); //<>//
    d = constrain(d,5,100);  //<>//
    float force = -1 * strength / (d * d);
    dir.mult(force);
    return dir;
  }
}
