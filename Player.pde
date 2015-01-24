class Player extends GameObject
{
  AudioPlayer Coin_Sound;
  AudioPlayer Player_Start_Sound;
  AudioPlayer Accelerator_Sound;


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
  PImage player_img;
  int coin = 0;
  boolean started;
  int score;
  int health;


  ArrayList<GameObject> bullets = new ArrayList<GameObject>();
  ArrayList<GameObject> bombs = new ArrayList<GameObject>();


  Player()
  {
    // alive=false;
    pos = new PVector(width / 2, height / 2);
    score = 0;
    health=50;
    Coin_Sound= minim.loadFile("Coin_Insertion.wav");
    Player_Start_Sound= minim.loadFile("car_start.wav");
    Accelerator_Sound= minim.loadFile("car_accelerating.wav");
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
    player_img = loadImage(imgPath);
    
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
    if (checkKey(insertcoin))
    {
      Coin_Sound.rewind();
      Coin_Sound.play(); 
     
      coin =1;
    }

    if (started) {
      if (checkKey(up))
      {
        Accelerator_Sound.rewind();
        Accelerator_Sound.play();
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
    }

    if (checkKey(start) && coin > 0)
    {
      Player_Start_Sound.rewind();
      Player_Start_Sound.play(); 
      coin = 0;
      started = true;
    }

    if (checkKey(button1))
    {
      // Bullet(float x, float y, String imgPath, float speed)
      //Bullet bullet = new Bullet(pos.x + 10, pos.y, "bullet.png", 8.0);

      if (frameCount % 10 == 0) {
        bullets.add(new Bullet(pos.x + 6, pos.y, "bullet.png", 8.0));
        bullets.add(new Bullet(pos.x + 30, pos.y, "bullet.png", 8.0));
      }
    }
    if (checkKey(button2))
    {
      if (frameCount % 10 == 0) {
        bombs.add(new Bomb(pos.x + 15, pos.y, "bomb.jpg", 8.0));
      }
    }
  }

  void display()
  {
    if (started) {
      for (int i = 0; i < bullets.size (); i++) {

        bullets.get(i).update();
        bullets.get(i).display();

        if (bullets.get(i).pos.y + bullets.get(i).h < 0) {
          bullets.get(i).alive = false;
        }

        if (bullets.get(i).alive == false) {
          bullets.remove( bullets.get(i) );
        }
      }
      
      for (int i = 0; i < bombs.size (); i++) {

        bombs.get(i).update();
        bombs.get(i).display();

        if (bombs.get(i).pos.y + bombs.get(i).h < 0) {
          bombs.get(i).alive = false;
        }

        if (bombs.get(i).alive == false) {
          bombs.remove( bombs.get(i) );
        }
      }
      image(player_img, pos.x, pos.y, w, h);

      println(bullets.size());
    }
  } // End display
  
  
  
  
  
  
  
  
  
  
  
}

