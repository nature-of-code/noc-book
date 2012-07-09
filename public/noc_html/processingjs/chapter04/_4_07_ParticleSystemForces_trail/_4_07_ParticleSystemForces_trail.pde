ParticleSystem ps;

void setup() {
  size(800, 200);
  background(255);
  smooth();
  ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
  rectMode(CORNER);
  noStroke();
  fill(255, 5);
  rect(0, 0, width, height);

  // Apply gravity force to all Particles
  PVector gravity = new PVector(0, 0.1);
  ps.applyForce(gravity);

  ps.addParticle();
  ps.run();
}

