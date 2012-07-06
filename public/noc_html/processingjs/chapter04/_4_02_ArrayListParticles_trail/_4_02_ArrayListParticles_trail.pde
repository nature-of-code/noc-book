ArrayList<Particle> particles;

void setup() {
  size(800,200);
  background(255);
  particles = new ArrayList<Particle>();
  smooth();
}

void draw() {
  
  noStroke();
  fill(255,5);
  rect(0,0,width,height);

  particles.add(new Particle(new PVector(width/2,50)));
  
  // Using the iterator 
  Iterator<Particle> it = particles.iterator();
  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
}




