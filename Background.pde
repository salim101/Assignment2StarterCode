class Background extends GameObject {
  PImage bk_img;

  Background() {
  }
  
  
  Background(float y, float w, float h, String imgPath) { //overload constructor
    //this();
    pos.y = y;
    this.w = w;
    this.h = h;
    bk_img = loadImage(imgPath);
  }//end Background

  void update() {
    pos.y += speed;
    if (pos.y >= 0) {
      pos.y = -height;
    }
  }//end update
  
  void display() {
    image(bk_img, pos.x, pos.y, w, h);
  }//end display
  
}//end class

