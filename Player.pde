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
  char insertcoin;
  int index;
  //color colour;
  PImage bk_img;

  Player()
  {
    alive=false;
    pos = new PVector(width / 2, height / 2);
  }

  Player(int index, String imgPath, char up, char down, char left, char right, char start, char button1, char button2, char insertcoin)
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
    this.insertcoin= insertcoin;
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
      , buttonNameToKey(xml, "insertcoin")
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
    if (checkKey(insertcoin))
    {
      coin =1;
    }
    if (alive) {
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
    } else {

      if (checkKey(start) && coin > 0)
      {
        coin = 0;
        println("Player " + index + " coins" + coin);
        game_state="";
        alive=true;
      }
    }
    if (checkKey(insertcoin))
      {
        println("Player " + index + " start");
        println("Player " + index +  " coins " + coin);
      }
    }

    void display()
    {    

      image(bk_img, pos.x, pos.y, w, h);
    }
  }

