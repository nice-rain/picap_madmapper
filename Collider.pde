class Collider {
  float strength = 100;
  PVector location =  new PVector(0, 2);
  float r = 10;

//constructor
 Collider (float x, float y) {
   //  location = new PVector(x, y);
 }

  void display() {
    stroke(255);
    fill(255);
    ellipse(location.x,location.y,r*2,r*2);
  }

//     PVector repel(Particle p) 
//     {
//       PVector dir = PVector.sub(location, p.location);
//       float d = dir.mag();
//       dir.normalize();
//       d = constrain(d,5,100);
//       float force = -1 * strength / (d * d);
//       dir.mult(force);
//       return dir;
//   }
}