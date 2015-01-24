class Bomb extends GameObject{
  PImage Bomb_img;
  
  Bomb(){
    w = 10;
    h = 10;
  }
  
  Bomb(String imgPath){
    this();
    Bomb_img = loadImage(imgPath);
  }
  
  Bomb(float x, float y, String imgPath, float speed){
    this(imgPath);
    this.pos.x = x;
    this.pos.y = y;
    this.speed = speed;
  }
  
  
  void update(){
    pos.y -= speed;
  }
  
  
  void display(){
    image(Bomb_img, pos.x, pos.y, w, h);
  }
  
}
