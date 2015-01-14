class GameObject
{
  boolean alive;
  PVector pos;
  float w, h;
  float theta, speed;
  color colour;

  GameObject() {
    w=60.0f;
    h=110.0f;
    speed = 3.0f;
    theta=0.0f;
    alive=true;
    pos = new PVector(0, 0);
  }
  void update() {
  }

  void display() {
    fill(colour);
    rect(pos.x, pos.y, w, h);
  }
}

