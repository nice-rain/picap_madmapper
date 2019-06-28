class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass = 500;
  float radius = 8;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.01);
    velocity = new PVector(random(-2, 2), 2);
    position = l.copy();
    lifespan = 1000.0;
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

      //We need to determine which side of the square we are on 
      if(position.y < collidedObject.location.y && acceleration.y > 0)
      {
        //we are on top, and moving down, invert y (works)
        velocity.y *= -0.8;
      }

      if(position.y > collidedObject.location.y + collidedObject.width && acceleration.y < 0)
      {
        //we are underneath, invert y
        velocity.y *= -0.8;
      }

      if(position.x < collidedObject.location.x && acceleration.x > 0)
      {
        //we are to the left and moving right, invert x
        velocity.x *= -0.8;
      }

      if(position.x > collidedObject.location.x + collidedObject.width && acceleration.x < 0){
        //we are on the right, moving left
        velocity.x *= -0.8;
      }

        //velocity.x *= -0.8;
        //velocity.y *= -0.8;
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
      //if(dist(position.x, position.y, collider.location.x, collider.location.y) <
       // radius + (collider.width/2))
        //  {
         //   return collider;
         // }
      
      if(position.x + radius > collider.location.x && position.x - radius < collider.location.x + collider.width && position.y + radius > collider.location.y && position.y - radius < collider.location.y + collider.width){
	      //the point is inside the rectangle
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
