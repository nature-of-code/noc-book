Mover mover;

void setup() {
  size(640,360);
  smooth();
  background(255);
  mover = new Mover(); 
}

void draw() {
  background(255);
  
  mover.update();
  mover.checkEdges();
  mover.display(); 
}

