class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
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