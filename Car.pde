class Car extends GameObject
{

  PImage car_img;

  Car() {
    pos.x = random( width/4, ((width/4)*3) -w  );
    pos.y = random(  -height*3, -height  );
  }

  Car(String imgPath) {
    this();
    car_img = loadImage(imgPath);
  }
  
  
  
  void update(){
    pos.y += speed;
  }
  
  
  void display(){
    image(car_img, pos.x, pos.y, w, h);
  }
  
}

