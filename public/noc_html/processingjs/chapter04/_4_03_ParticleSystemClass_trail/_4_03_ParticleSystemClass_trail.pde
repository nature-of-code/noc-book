ParticleSystem ps;

void setup() {
  size(800,200);
  background(255);
  smooth();
  ps = new ParticleSystem(new PVector(width/2,50));
}

void draw() {
  
  noStroke();
  fill(255,5);
  rect(0,0,width,height);
  
  ps.addParticle();
  ps.run();
}
