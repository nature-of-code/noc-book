Particle p;

void setup() {
  size(640, 360);
  p = new Particle(new PVector(width/2, 20));
  background(255);
  smooth();
}

void draw() {
  noStroke();
  fill(255, 5);
  rect(0, 0, width, height);

  p.run();
  if (p.isDead()) {
    println("Particle dead!");
  }
}


