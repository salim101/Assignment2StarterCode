class Player extends GameObject
{
  //PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  //color colour;
  PImage bk_img;
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
  }
  
  Player(int index, String imgPath, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    bk_img = loadImage(imgPath);
  }
  
  Player(int index, String imgPath, XML xml)
  {
    this(index
        , imgPath
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
    if (checkKey(up))
    {
      pos.y -= speed;
    }
    if (checkKey(down))
    {
      pos.y += speed;
    }
    if (checkKey(left))
    {
      pos.x -= speed;
    }    
    if (checkKey(right))
    {
      pos.x += speed;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }    
  }
  
  void display()
  {    
        
    image(bk_img,pos.x, pos.y, w, h);
  }  
}
