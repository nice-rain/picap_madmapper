class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass = 500;
  float radius = 8;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.01);
    velocity = new PVector(random(-1, 1), 0);
    position = l.copy();
    lifespan = 255.0;
  }

  //Called from ParticleSystem, checks for collision and moves our particle.
  void run(ArrayList<Collider> colliders) {
    update(colliders);
    display();
  }

  // Method to update position
  void update(ArrayList<Collider> colliders) {
    velocity.add(acceleration);
    
    //Check collision
    Collider collidedObject = checkCollision(colliders);
    if(collidedObject != null){
      velocity.x *= -1;
      velocity.y *= -1;
    }
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, radius, radius);
  }

  Collider checkCollision(ArrayList<Collider> colliders)
  {
    //println("CheckCollision");
    //Loop through all colliders
    for(Collider collider: colliders)
    {
      //check to see if it entered X axis
      if(dist(position.x, position.y, collider.location.x, collider.location.y) <
        radius + (collider.width/2))
          {
            return collider;
          }
    }
    return null;
  }


  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
    void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }
}
