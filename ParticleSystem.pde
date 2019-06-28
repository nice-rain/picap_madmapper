class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    PVector newOrigin = new PVector(random(100, 1200), origin.y);
    particles.add(new Particle(newOrigin));
  }

  void run(ArrayList<Collider> colliders) {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      //Call particle run to move it
      p.run(colliders);
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  void applyCollision(Collider c) {
    for (Particle p: particles) {
      PVector force = c.repel(p);
      p.applyForce(force);
    }
  }
}