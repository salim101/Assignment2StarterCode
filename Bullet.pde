class Bullet extends GameObject {
  PImage Bullet_img;

  Bullet() {
    w = 3;
    h = 10;
  }//end Bullet

  Bullet(String imgPath) {
    this();
    Bullet_img = loadImage(imgPath);
  } //end Bullet

  Bullet(float x, float y, String imgPath, float speed) {
    this(imgPath);
    this.pos.x = x;
    this.pos.y = y;
    this.speed = speed;
  }//end Bullet


  void update() {
    pos.y -= speed;
  }//end update


  void display() {
    image(Bullet_img, pos.x, pos.y, w, h);
  }//end display
  
}//end bullet class




