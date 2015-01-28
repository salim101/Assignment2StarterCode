class Horse extends GameObject
{

  PImage horse_img;

  Horse() {
    pos.x = random( width/4, ((width/4)*3) -w  );
    pos.y = random(  -height*3, -height  );
  }//end Horse

  Horse(String imgPath) {
    this();
    horse_img = loadImage(imgPath);
  }//end Horse



  void update() {
    pos.y += speed;
  }//end update


  void display() {
    image(horse_img, pos.x, pos.y, w, h);
  }//end display
  
}//end class

