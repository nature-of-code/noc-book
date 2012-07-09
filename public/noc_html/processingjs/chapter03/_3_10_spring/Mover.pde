// Nature of Code 2011
// Daniel Shiffman
// Chapter 3: Oscillation

// Bob class, just like our regular Mover (location, velocity, acceleration, mass)

class Bob { 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 10;
  
  // Arbitrary damping to simulate friction / drag 
  float damping = 0.98;

  // For mouse interaction
  PVector drag;
  boolean dragging = false;

  // Constructor
  Bob(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
    drag = new PVector();
  } 

  // Standard Euler integration
  void update() { 
    velocity.add(acceleration);
    velocity.mult(damping);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton's law: F = M * A
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }


  // Draw the bob
  void display() { 
    stroke(255);
    fill(100);
    if (dragging) {
      fill(255);
    }
    ellipse(location.x,location.y,48,48);
  } 

  // The methods below are for mouse interaction

  // This checks to see if we clicked on the mover
  void clicked(int mx, int my) {
    float d = dist(mx,my,location.x,location.y);
    if (d < mass) {
      dragging = true;
      drag.x = location.x-mx;
      drag.y = location.y-my;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      location.x = mx + drag.x;
      location.y = my + drag.y;
    }
  }
}

