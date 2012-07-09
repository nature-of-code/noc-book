// Simple Particle System
// Daniel Shiffman <http://www.shiffman.net>

// Particles are generated each cycle through draw(),
// fall with gravity and fade out over time
// A ParticleSystem object manages a variable size (ArrayList) 
// list of particles.

ParticleSystem ps;

void setup() {
  size(640,360);
  ps = new ParticleSystem(1,new PVector(width/2,50));
  smooth();
}

void draw() {
  background(255);
  ps.run();
  ps.addParticle();
}



