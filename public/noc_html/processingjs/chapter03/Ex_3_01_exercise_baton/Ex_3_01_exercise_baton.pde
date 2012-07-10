float angle = 0;			

void setup() {
  size(800, 200);
  smooth();
}

void draw() {
  background(50);

  fill(175);
  stroke(255);
  rectMode(CENTER);
  translate(width/2, height/2);
  rotate(angle);
  line(-50, 0, 50, 0);
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(50, 0, 48, 48);
  ellipse(-50, 0, 48, 48);

  angle += 0.05;
}

