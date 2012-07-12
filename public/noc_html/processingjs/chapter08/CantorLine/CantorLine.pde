
void setup() {
  size(800,200);
  background(255);
}

void cantor(float x, float y, float len) {
  line(x, y, x+len, y);
}

void draw() {
  cantor(10, 20, width-20);
}

