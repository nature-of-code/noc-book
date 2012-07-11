
float h = 30;

void setup() {
  size(300,120);
  background(255);
  cantor(10, 20, width-20);
  saveFrame("figure.png");
}

void draw() {
}


void cantor(float x, float y, float len) {
  if (len >= 1) {
    line(x,y,x+len,y);
    y += 20;
    cantor(x,y,len/3);
    cantor(x+len*2/3,y,len/3);
  }
}
