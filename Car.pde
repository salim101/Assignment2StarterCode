class Car extends GameObject
{

  PImage bk_img;

  Car() {
    pos.x = random( width/4, ((width/4)*3) -w  );
    pos.y = random(  -height*3, -height  );
  }

  Car(String imgPath) {
    this();
    bk_img = loadImage(imgPath);
  }
  
  
  
  void update(){
    pos.y += speed;
  }
  
  
  void display(){
    image(bk_img, pos.x, pos.y, w, h);
  }
  
}

