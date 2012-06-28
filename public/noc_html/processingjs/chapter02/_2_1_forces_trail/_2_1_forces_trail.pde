Mover m;

void setup() {
  background(255);
  size(800, 200);
  smooth();
  m = new Mover();
}

void draw() {
  //background(255);

  PVector wind = new PVector(0.01, 0);
  PVector gravity = new PVector(0, 0.1);
  m.applyForce(wind);
  m.applyForce(gravity);


  m.update();
  m.display();
  m.checkEdges();

  noStroke();
  fill(255, 5);
  rect(0, 0, width, height);
}



