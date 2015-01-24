class Extra_Health extends GameObject{
  PImage Extra_Health_img;
  
  Extra_Health(){
    w = 20;
    h = 20;
    pos.x = random( width/4, ((width/4)*3) -w  );
    pos.y = random(  -height*3, -height  );
  }
  
  Extra_Health(String imgPath){
    this();
    Extra_Health_img = loadImage(imgPath);
  }
  
  void update(){
    pos.y += speed;
  }
  
  
  void display(){
    image(Extra_Health_img, pos.x, pos.y, w, h);
  }
  
}
