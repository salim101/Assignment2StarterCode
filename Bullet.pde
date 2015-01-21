class Bullet extends GameObject{
  PImage Bullet_img;
  
  Bullet(){
    w = 3;
    h = 10;
  }
  
  Bullet(String imgPath){
    this();
    Bullet_img = loadImage(imgPath);
  }
  
  Bullet(float x, float y, String imgPath, float speed){
    this(imgPath);
    this.pos.x = x;
    this.pos.y = y;
    this.speed = speed;
  }
  
  
  void update(){
    pos.y -= speed;
  }
  
  
  void display(){
    image(Bullet_img, pos.x, pos.y, w, h);
  }
  
  
}//end bullet class





