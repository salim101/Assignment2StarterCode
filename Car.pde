class Car extends GameObject
{

  PImage car_img;

  Car() {
    pos.x = random( width/4, ((width/4)*3) -w  );
    pos.y = random(  -height*3, -height  );
  }//end Car

  Car(String imgPath) {
    this();
    car_img = loadImage(imgPath);
  }//end Car



  void update() {
    pos.y += speed;
  }//end update


  void display() {
    image(car_img, pos.x, pos.y, w, h);
  }//end display
  
}//end class

