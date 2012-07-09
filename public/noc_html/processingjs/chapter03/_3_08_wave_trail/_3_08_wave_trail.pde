
float startAngle = 0;
float angleVel = 0.23;

void setup() {
  size(800,200);
  background(255);
  smooth();
}

void draw() {
  
  noStroke();
  fill(255,50);
  rect(0,0,width,height);

  startAngle += 0.015;
  float angle = startAngle;

 for (int x = 0; x <= width; x += 24) {
    float y = map(sin(angle),-1,1,0,height);
    stroke(0);
    fill(0,50);
    strokeWeight(2);
    ellipse(x,y,48,48);
    angle += angleVel;
  } 

}



