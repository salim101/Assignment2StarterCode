class Bomb extends GameObject {
  PImage Bomb_img;

  Bomb() {
    w = 10;
    h = 10;
  }//end Bomb

  Bomb(String imgPath) {
    this();
    Bomb_img = loadImage(imgPath);
  }//end Bomb

  Bomb(float x, float y, String imgPath, float speed) {
    this(imgPath);
    this.pos.x = x;
    this.pos.y = y;
    this.speed = speed;
  }//end Bomb


  void update() {
    pos.y -= speed;
  }//end update


  void display() {
    image(Bomb_img, pos.x, pos.y, w, h);
  }//end display
  
}//end class

